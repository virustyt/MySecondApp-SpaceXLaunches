//
//  UIButton_leftImage.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 18.11.2021.
//

import UIKit

extension UIButton {
    func addRightImage(image: UIImage, offset: CGFloat) {
        self.setImage(image, for: .normal)
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset).isActive = true
        
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        self.titleLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offset).isActive = true
    }
    
    static func setUpTolinkButton (withTitle: String) {
        
    }
}
