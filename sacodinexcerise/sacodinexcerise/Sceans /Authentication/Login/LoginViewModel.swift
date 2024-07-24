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
    func moveToInspections()
}

class LoginViewModel: LoginViewModelType {
    var email = CurrentValueSubject<String, Never>("")
    var password = CurrentValueSubject<String, Never>("")
    var loginResult = PassthroughSubject<Result<Empty, NetworkRequestError>, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    private let authenticationService: AuthenticationServicesType
    private let navigator: NavigatorType
    init(authenticationService: AuthenticationServicesType,
         navigator: NavigatorType) {
        self.authenticationService = authenticationService
        self.navigator = navigator
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
    
    func moveToInspections() {
        navigator.navigate(to: .inspections)
    }
}
