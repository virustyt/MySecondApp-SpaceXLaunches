//
//  linkButton.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 19.11.2021.
//

import UIKit

class linkButton: UIButton {

    init(title: String){
        super.init(frame: .zero)
        print("button layer after init\(layer.masksToBounds)")
        backgroundColor = .brown
        isOpaque = true
//        clipsToBounds = true

        let linkImage = UIImage(named: "button-link") ?? UIImage()
        let linkImageView = UIImageView(image: linkImage)
        linkImageView.contentMode = .scaleAspectFit
        linkImageView.translatesAutoresizingMaskIntoConstraints = false
//        linkImageView.backgroundColor = .blue

        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 17) ?? UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.coral
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .green

        addSubview(linkImageView)
        addSubview(label)
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + linkImage.size.width + 30),
            heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height + 10),

            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            label.trailingAnchor.constraint(equalTo: linkImageView.leadingAnchor,constant: 7.5),

            linkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            linkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12.5)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
        print("button layer after set corner radius\(layer.masksToBounds)")
        if layer.shadowPath == nil { 
            layer.setUpShadows(withShadowCornerRadius: frame.size.height / 2)
            print("hello")
            backgroundColor = .red
        } 
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
