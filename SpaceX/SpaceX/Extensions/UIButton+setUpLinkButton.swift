//
//  UIButton_leftImage.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 18.11.2021.
//

import UIKit

extension UIButton {
    
    static func setUpTolinkButton (withTitle title: String) -> UIButton{
        let linkImage = UIImage(named: "button-link") ?? UIImage()
        let linkImageView = UIImageView(image: linkImage)
        linkImageView.contentMode = .scaleAspectFit
        linkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 17) ?? UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.coral
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false

//        let button = LinkButton(type: .custom)
        let button = UIButton(type: .custom)
        
        button.addSubview(linkImageView)
        button.addSubview(label)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + linkImage.size.width + 30),
            button.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height + 10),
            
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor,constant: 10),
            label.trailingAnchor.constraint(equalTo: linkImageView.leadingAnchor,constant: 7.5),
            
            linkImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            linkImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 12.5)
        ])

        return button
    }
}
