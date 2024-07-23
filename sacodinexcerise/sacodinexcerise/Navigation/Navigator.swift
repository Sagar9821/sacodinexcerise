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
    var childNavigator: [ChildNavigator] { get }
    var navigationController: UINavigationController { get }
    
    func startUserFlow(with entrypoint: UserFlowEntryPoint)
    func navigate(to destination: Destinations)
}

protocol ChildNavigator {
    var rootNavigator: NavigatorType { get }
    func navigate(to destination: Destinations)
    func start()
}

class Navigator: NavigatorType {
    var childNavigator: [ChildNavigator] = []
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startUserFlow(with entrypoint: UserFlowEntryPoint) {
        
        let onboardingVm: OnBoardingViewModel = OnBoardingViewModel(navigator: self)
        let onboardingVc = SAStoryboard.authentication.instantiateViewController(identifier: OnboardingViewController.storyboardID) { coder in
            return OnboardingViewController(coder: coder, viewModel: onboardingVm)
        }
        
        switch entrypoint {
        case .onboading:
            navigationController.pushViewController(onboardingVc, animated: false)
        case .inspections:
            let inspectionNavigator: InspectionNavigator = InspectionNavigator(rootNavigator: self)
            childNavigator.append(inspectionNavigator)
            navigationController.viewControllers.append(onboardingVc)
            inspectionNavigator.start()
            
        }
    }
    
    func navigate(to destination: Destinations) {
        switch destination {
        case .login:
            let loginVm: LoginViewModel = LoginViewModel(authenticationService: AuthenticationServices(webService: WebService(), persistentData: PersistentData()), navigator: self)
            let loginVc = SAStoryboard.authentication.instantiateViewController(identifier: LoginViewController.storyboardID) { coder in
                return LoginViewController(coder: coder,viewModel: loginVm)
            }
            navigationController.pushViewController(loginVc, animated: true)
        case .signup:
            let signUpVm: SignUpViewModel = SignUpViewModel(authenticationService: AuthenticationServices(webService: WebService(), persistentData: PersistentData()), navigator: self)
            let loginVc = SAStoryboard.authentication.instantiateViewController(identifier: SignUpViewController.storyboardID) { coder in
                return SignUpViewController(coder: coder,viewModel: signUpVm)
            }
            navigationController.pushViewController(loginVc, animated: true)
        case .inspection:
            let inspectionNavigator: InspectionNavigator = InspectionNavigator(rootNavigator: self)
            childNavigator.append(inspectionNavigator)            
            inspectionNavigator.start()
        }
    }
    
}
