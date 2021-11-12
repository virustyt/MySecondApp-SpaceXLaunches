//
//  UILabel+staticLabels.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 12.11.2021.
//

import UIKit

extension UILabel {
    static let titleLabelOne: UILabel = {
        let label = UILabel()
        label.font = UIFont.forTitle
        label.tintColor = UIColor.smokyBlack
        label.textAlignment = .left
        return label
    }()
    
    static let titleLabelTwo: UILabel = {
        let label = UILabel()
        label.font = UIFont.forBody
        label.tintColor = UIColor.smokyBlack
        label.textAlignment = .left
        return label
    }()
    
    static let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.forBody
        label.tintColor = UIColor.slateGray
        label.textAlignment = .left
        return label
    }()
}
