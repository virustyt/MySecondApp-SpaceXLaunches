//
//  UIFont+RobotoFonts.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 11.11.2021.
//

import UIKit

extension UIFont {
    static let forTitle = UIFont(name: "Roboto-Bold", size: 24)
    static let forBody = UIFont(name: "Roboto-Bold", size: 14)
    static let forTabBarItems = UIFont(name: "Roboto-Medium", size: 10) ?? UIFont.systemFont(ofSize: 10)
    static let forDescriptionTitle = UIFont(name: "Roboto-Bold", size: 24)
    static let forDescriptionBody = UIFont(name: "Roboto-Medium", size: 14)
}
