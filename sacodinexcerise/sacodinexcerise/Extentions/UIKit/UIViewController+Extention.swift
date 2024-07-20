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
