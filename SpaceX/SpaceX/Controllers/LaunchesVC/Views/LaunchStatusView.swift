//
//  LaunchStatusView.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 14.12.2021.
//

import UIKit

class LaunchStatusView: UIView {

    private let statusImageView = UIImageView()
    var image: UIImage? {
        didSet{
            statusImageView.image = image
        }
    }
    private var haveShadows = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        statusImageView.backgroundColor = .white
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(statusImageView)
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusImageView.topAnchor.constraint(equalTo: topAnchor),
            statusImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if image != nil, !haveShadows {
            layer.cornerRadius = frame.size.height / 2
            layer.setUpShadows(withShadowCornerRadius: frame.size.height / 2)
            statusImageView.layer.cornerRadius = frame.size.height / 2
            statusImageView.layer.masksToBounds = true
            haveShadows = true
        }
    }

}

