//
//  UIButton+Extentions.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import UIKit

extension UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
    }
}

