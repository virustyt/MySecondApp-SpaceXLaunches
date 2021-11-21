//
//  UILabel+staticLabels.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 12.11.2021.
//

import UIKit

extension UILabel {
    static var titleLabelOne: UILabel  {
        let label = UILabel()
        label.font = UIFont.forTitle
        label.textColor = UIColor.smokyBlack
        label.textAlignment = .left
        return label
    }
    
    static var titleLabelTwo: UILabel{
        let label = UILabel()
        label.font = UIFont.forBody
        label.textColor = UIColor.smokyBlack
        label.textAlignment = .left
        return label
    }
    
    static var bodyLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.forBody
        label.textColor = UIColor.slateGray
        label.textAlignment = .left
        return label
    }
    
    static var sortOptionLabel: UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        label.tintColor = UIColor.coral
        label.textAlignment = .left
        return label
    }
    
    static var descriptionTitleLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.forDescriptionTitle
        label.tintColor = UIColor.smokyBlack
        label.textAlignment = .left
        return label
    }
    
    static var descriptionBodyLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.forDescriptionBody
        label.tintColor = UIColor.smokyBlack
        label.textAlignment = .left
        return label
    }
}
