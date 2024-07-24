//
//  WebService.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
import Combine

protocol WebServiceType {
    func dispatch<ReturnType: Codable>(_ type: ReturnType.Type, router: Router) -> AnyPublisher<ReturnType, NetworkRequestError>
}

struct WebService: WebServiceType {
    
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Codable>(_ type: ReturnType.Type, router: Router) -> AnyPublisher<ReturnType, NetworkRequestError> {
            
        guard let request = createRequest(router: router) else {
            return Fail(error: NetworkRequestError.invalidRequest).eraseToAnyPublisher()
        }
        
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { data, response in
                
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkRequestError.invalidRequest
                }
                
                print("[\(response.statusCode)] '\(request.url!)'")
                
                if response.statusCode == 401 || response.statusCode == 409 {
                    // Decode error model for status code 400
                    let decoder = JSONDecoder()
                    let errorModel = try decoder.decode(WebResponseError.self, from: data)
                    throw NetworkRequestError.custome(errorModel)
                } else if !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                
                return data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: type.self, decoder: JSONDecoder())
            .mapError { error in
                return handleError(error)
            }
            .catch { error -> AnyPublisher<ReturnType, NetworkRequestError> in
                // Handle empty data case
                
                if case .decodingError = error, type.self == Empty.self{
                    // Create an empty instance of T if possible, or handle as needed
                    let emptyResponse = Empty() // Assuming T has a default initializer
                    return Just(emptyResponse as! ReturnType)
                        .setFailureType(to: NetworkRequestError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func createRequest(router: Router) -> URLRequest? {
        guard let url = URL(string: router.path) else { return nil }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = router.method.rawValue
        request.httpBody = router.parameters
        print("[\(request.httpMethod!)] '\(request.url!)'")
        if router.method == .post {
            request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        return request
    }
}

// MARK: - Error Handling

enum NetworkRequestError: LocalizedError {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case timeOut
    case unknownError
    case custome( _ error: WebResponseError)
}

extension NetworkRequestError {
    var errorMessage: String? {
        switch self {
        case .invalidRequest:
            return "Please try after sometime"
        case .badRequest:
            return "Please try after sometime"
        case .unauthorized:
            return "Please try after sometime"
        case .forbidden:
            return "Please try after sometime"
        case .notFound:
            return "Please try after sometime"
        case .error4xx(let _):
            return "Please try after sometime"
        case .serverError:
            return "Please try after sometime"
        case .error5xx(let _):
            return "Please try after sometime"
        case .decodingError:
            return "Please try after sometime"
        case .urlSessionFailed(let _):
            return "Please try after sometime"
        case .timeOut:
            return "Please try after sometime"
        case .unknownError:
            return "Please try after sometime"
        case .custome(let responseError):
            return responseError.error
        }
    }
}

extension WebService {
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case let error as DecodingError :
            handleDecodingError(error)
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
    
    func handleDecodingError(_ error: DecodingError) {
        switch error {
        case .typeMismatch(let type, let context):
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("CodingPath:", context.codingPath)
        case .valueNotFound(let type, let context):
            print("Value '\(type)' not found:", context.debugDescription)
            print("CodingPath:", context.codingPath)
        case .keyNotFound(let key, let context):
            print("Key '\(key)' not found:", context.debugDescription)
            print("CodingPath:", context.codingPath)
        case .dataCorrupted(let context):
            print("Data corrupted:", context.debugDescription)
            print("CodingPath:", context.codingPath)
        @unknown default:
            print("Unknown decoding error")
        }
    }
}
