//
//  Router.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation

protocol RouterType {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Data? { get }
}

enum Router: RouterType {
    case login(AuthenticationResource)
    case register(AuthenticationResource)
    case startInpection
}

extension Router {
    var path: String {
        switch self {
        case .login:
            return "http://127.0.0.1:5001/api/login"
        case .register:
            return "http://127.0.0.1:5001/api/register"
        case .startInpection:
            return "http://127.0.0.1:5001/api/inspections/start"
        }
    }
}

extension Router {
    var method: HTTPMethod {
        switch self {
        case .login,.register:
            return .post
        case .startInpection:
            return .get
        }
    }
}

extension Router {
    var parameters: Data? {
        switch self {
        case .login(let authenticationResource),.register(let authenticationResource):
            return getParameters(authenticationResource)
        case .startInpection:
            return nil
        }
    }
    
    func getParameters( _ data: Encodable) -> Data?{
        do {
            let params = try JSONEncoder().encode(data)
            return params
        } catch {
            print("error creating request \(error.localizedDescription)")
        }
        return nil
    }
}

