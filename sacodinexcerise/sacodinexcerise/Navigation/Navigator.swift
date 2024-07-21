//
//  Navigator.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
import UIKit

enum UserFlowEntryPoint {
    case onboading
    case inspections
}

protocol NavigatorType {
    func startUserFlow(with entrypoint: UserFlowEntryPoint)
    func navigate(to destination: Destinations)
}

class Navigator: NavigatorType {
    
    private let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startUserFlow(with entrypoint: UserFlowEntryPoint) {
        switch entrypoint {
        case .onboading:
            let onboardingVm: OnBoardingViewModel = OnBoardingViewModel(navigator: self)
            let onboardingVc = SAStoryboard.authentication.instantiateViewController(identifier: OnboardingViewController.storyboardID) { coder in
                return OnboardingViewController(coder: coder, viewModel: onboardingVm)
            }
            navigationController.pushViewController(onboardingVc, animated: false)
        
        case .inspections:
            let inspectionsVc = SAStoryboard.inspection.instantiateViewController(identifier: QuestionAndAnswerViewController.storyboardID) { coder in
                return QuestionAndAnswerViewController(coder: coder)
            }
            navigationController.pushViewController(inspectionsVc, animated: false)
        
            
        }
    }
    
    func navigate(to destination: Destinations) {
        switch destination {
        case .login:
            let loginVm: LoginViewModel = LoginViewModel(authenticationService: AuthenticationServices(webService: WebService(), persistentData: PersistentData()))
            let loginVc = SAStoryboard.authentication.instantiateViewController(identifier: LoginViewController.storyboardID) { coder in
                return LoginViewController(coder: coder,viewModel: loginVm)
            }
            navigationController.pushViewController(loginVc, animated: true)
        case .signup:
            let loginVc = SAStoryboard.authentication.instantiateViewController(identifier: LoginViewController.storyboardID) { coder in
                return LoginViewController(coder: coder)
            }
            navigationController.pushViewController(loginVc, animated: true)
        case .inspection:
            let loginVc = SAStoryboard.authentication.instantiateViewController(identifier: LoginViewController.storyboardID) { coder in
                return LoginViewController(coder: coder)
            }
            navigationController.pushViewController(loginVc, animated: true)
        }
    }
    
}
