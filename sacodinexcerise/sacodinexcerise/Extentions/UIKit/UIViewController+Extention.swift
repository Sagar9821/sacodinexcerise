//
//  UIViewController+Extention.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
import UIKit

extension UIViewController {
    static var storyboardID: String {
        return String(describing: self)
    }
}

extension UIViewController {
    func navigationBar(title: String) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.configureWithOpaqueBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: AppColor.Text.oceanBlue
        ]
        appearance.titleTextAttributes = attributes
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.title = title
    }
    
    func showNetworkError(_ error: NetworkRequestError) {
        DispatchQueue.dispatchToMain {
            let alertError: UIAlertController = UIAlertController(title: "Error", message: error.errorMessage ?? "Please try sometime.", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertError, animated: true)
        }
    }
    
    func showLoader() {
        DispatchQueue.dispatchToMain {
            SwiftLoader.show(animated: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.dispatchToMain {
            SwiftLoader.hide()
        }
    }
}
