//
//  Navigator.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
import UIKit
public enum UserFlowEntryPoint {
    case login
    case inspections
}

public protocol NavigatorType {
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
        case .login:
            let loginVc = SAStoryboard.authentication.instantiateViewController(identifier: LoginViewController.storyboardID) { coder in
                return LoginViewController(coder: coder)
            }
            navigationController.pushViewController(loginVc, animated: false)
        case .inspections:
            let inspectionsVc = SAStoryboard.authentication.instantiateViewController(identifier: LoginViewController.storyboardID) { coder in
                return LoginViewController(coder: coder)
            }
            navigationController.pushViewController(inspectionsVc, animated: false)
        }
    }
    
    func navigate(to destination: Destinations) {
       
    }
    
}
