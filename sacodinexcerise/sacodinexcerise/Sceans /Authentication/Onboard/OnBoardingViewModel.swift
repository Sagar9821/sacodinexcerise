//
//  OnBoardingViewModel.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation

protocol OnboardingViewModelType {
    func moveToLogin()
    func moveToRegister()
}

class OnBoardingViewModel: OnboardingViewModelType {
    
    var navigator: NavigatorType
    init(navigator: NavigatorType) {
        self.navigator = navigator
    }
    
    func moveToLogin() {
        navigator.navigate(to: .login)
    }
    
    func moveToRegister() {
        navigator.navigate(to: .signup)
    }
}
