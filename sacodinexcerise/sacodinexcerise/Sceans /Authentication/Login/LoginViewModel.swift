//
//  LoginViewModel.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
import Combine

protocol LoginViewModelType {
    var email: CurrentValueSubject<String, Never> { get }
    var password: CurrentValueSubject<String, Never> { get }
    var loginResult: PassthroughSubject<Result<Empty, NetworkRequestError>, Never> { get }
    
    func login()
}

class LoginViewModel: LoginViewModelType {
    var email = CurrentValueSubject<String, Never>("")
    var password = CurrentValueSubject<String, Never>("")
    var loginResult = PassthroughSubject<Result<Empty, NetworkRequestError>, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    private let authenticationService: AuthenticationServicesType
    
    init(authenticationService: AuthenticationServicesType) {
        self.authenticationService = authenticationService
    }
    
    
    
    func login() {
        authenticationService.login(email: email.value, password: password.value)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.loginResult.send(.failure(error))
                }
            }, receiveValue: { [weak self] authResource in
                self?.loginResult.send(.success(authResource))
            })
            .store(in: &cancellables)
    }
    
    
}
