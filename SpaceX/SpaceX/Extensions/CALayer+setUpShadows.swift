//
//  CALayer+customShadows.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 19.11.2021.
//

import UIKit

class myLayer: CALayer {
    override var masksToBounds: Bool {
        didSet{
            print()
        }
    }
}


extension CALayer {
    func setUpShadows(withShadowCornerRadius: CGFloat) {

        let layer0 = CALayer()
        layer0.frame = bounds
        layer0.backgroundColor = backgroundColor
        layer0.shadowColor = UIColor(red: 0.68, green: 0.68, blue: 0.75, alpha: 0.4).cgColor
        layer0.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer0.shadowRadius = 3
        layer0.shadowOpacity = 1
        layer0.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: withShadowCornerRadius).cgPath
        insertSublayer(layer0, at: 0)

        let layer1 = CALayer()
        layer1.frame = bounds
        layer1.backgroundColor = backgroundColor
        layer1.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.shadowOffset = CGSize(width: -1, height: -1)
        layer1.shadowRadius = 3
        layer1.shadowOpacity = 1
        layer1.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: withShadowCornerRadius).cgPath
        insertSublayer(layer1, at: 0)
    }
}

