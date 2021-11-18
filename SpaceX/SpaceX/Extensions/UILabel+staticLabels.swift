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
        label.tintColor = UIColor.smokyBlack
        label.textAlignment = .left
        label.text = "placeholder"
        return label
    }
    
    static var titleLabelTwo: UILabel{
        let label = UILabel()
        label.font = UIFont.forBody
        label.tintColor = UIColor.smokyBlack
        label.textAlignment = .left
        label.text = "placeholder"
        return label
    }
    
    static var bodyLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.forBody
        label.tintColor = UIColor.slateGray
        label.textAlignment = .left
        label.text = "placeholder"
        return label
    }
    
    static var sortOptionLabel: UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        label.tintColor = UIColor.coral
        label.textAlignment = .left
        label.text = "placeholder"
        return label
    }
}
