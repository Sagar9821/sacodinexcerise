//
//  SignUpViewModel.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import Foundation
import Combine

protocol SignUpViewModelType {
    var email: CurrentValueSubject<String, Never> { get }
    var password: CurrentValueSubject<String, Never> { get }
    var signUpResult: PassthroughSubject<Result<Empty, NetworkRequestError>, Never> { get }
    
    func signUp()
    func moveToInspections()
    func moveToLogin()
}

class SignUpViewModel: SignUpViewModelType {
    var email = CurrentValueSubject<String, Never>("")
    var password = CurrentValueSubject<String, Never>("")
    var signUpResult = PassthroughSubject<Result<Empty, NetworkRequestError>, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    private let authenticationService: AuthenticationServicesType
    private let navigator: NavigatorType
    init(authenticationService: AuthenticationServicesType,
         navigator: NavigatorType) {
        self.authenticationService = authenticationService
        self.navigator = navigator
    }
    
    
    
    func signUp() {
        authenticationService.register(email: email.value, password: password.value)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.signUpResult.send(.failure(error))
                }
            }, receiveValue: { [weak self] authResource in
                self?.signUpResult.send(.success(authResource))
            })
            .store(in: &cancellables)
    }
    
    func moveToInspections() {
        navigator.navigate(to: .inspection)
    }
    
    func moveToLogin() {
        navigator.navigate(to: .login)
    }
}
