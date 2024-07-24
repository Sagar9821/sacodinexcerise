//
//  UINavigationController+Extentions.swift
//  sacodinexcerise
//
//  Created by psagc on 24/07/24.
//


import UIKit


extension UINavigationController {
    func popTo<T: UIViewController>(controller: T.Type, animation: Bool = true) {
        for preViewController in self.viewControllers {
            self.popToViewController(preViewController, animated: animation)
        }
    }
}
