//
//  SACornerRadiusView.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
import UIKit

@IBDesignable
class SACornerRadiusView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateCorners()
        }
    }

    @IBInspectable var topLeft: Bool = false {
        didSet {
            updateCorners()
        }
    }

    @IBInspectable var topRight: Bool = false {
        didSet {
            updateCorners()
        }
    }

    @IBInspectable var bottomLeft: Bool = false {
        didSet {
            updateCorners()
        }
    }

    @IBInspectable var bottomRight: Bool = false {
        didSet {
            updateCorners()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCorners()
    }

    private func updateCorners() {
        var corners = UIRectCorner()
        if topLeft {
            corners.insert(.topLeft)
        }
        if topRight {
            corners.insert(.topRight)
        }
        if bottomLeft {
            corners.insert(.bottomLeft)
        }
        if bottomRight {
            corners.insert(.bottomRight)
        }

        if corners.isEmpty {
            layer.mask = nil
        } else {
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
