//
//  AuthenticationServices.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
import Combine
struct AuthenticationResource : Codable {
    var email: String
    var password: String
}


protocol AuthenticationServicesType {
    func login(email: String, password: String) -> AnyPublisher<Empty,NetworkRequestError>
    func register(email: String, password: String) -> AnyPublisher<Empty,NetworkRequestError>
}

class AuthenticationServices: AuthenticationServicesType {
    
    var webService: WebServiceType
    var persistentData: PersistentDataType
    init(webService: WebServiceType,
         persistentData: PersistentDataType) {
        self.webService = webService
        self.persistentData = persistentData
    }
    func login(email: String, password: String) -> AnyPublisher<Empty,NetworkRequestError> {
        let userDetails: AuthenticationResource = AuthenticationResource(email: email, password: password)
        return webService.dispatch(Empty.self, router: .login(userDetails))
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.saveAuthenticationResource(userDetails)
            })
            .eraseToAnyPublisher()
        
    }
    
    func register(email: String, password: String) -> AnyPublisher<Empty,NetworkRequestError> {
        return webService.dispatch(Empty.self, router: .register(AuthenticationResource(email: email, password: password)))
    }
    
    private func saveAuthenticationResource(_ resource: AuthenticationResource) {
        persistentData.userDetails = resource
    }
    
}
