//
//  LogoView.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 14.12.2021.
//

import UIKit

class LogoView: UIView {
    
    let logoImageView = UIImageView()
    let containerForImageView = UIView()
    var image: UIImage? {
        didSet{
            logoImageView.image = image
        }
    }
    private var haveShadows = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerForImageView.backgroundColor = .white
        logoImageView.contentMode = .scaleAspectFit
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(containerForImageView)
        containerForImageView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        containerForImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerForImageView.topAnchor.constraint(equalTo: topAnchor),
            containerForImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerForImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerForImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerForImageView.topAnchor,constant: 15),
            logoImageView.leadingAnchor.constraint(equalTo: containerForImageView.leadingAnchor,constant: 9.5),
            logoImageView.trailingAnchor.constraint(equalTo: containerForImageView.trailingAnchor,constant: -9.5),
            logoImageView.bottomAnchor.constraint(equalTo: containerForImageView.bottomAnchor,constant: -15)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if image != nil, !haveShadows {
            layer.cornerRadius = 20
            layer.setUpShadows(withShadowCornerRadius: 20)
            containerForImageView.layer.cornerRadius = 20
            containerForImageView.layer.masksToBounds = true
            haveShadows = true
        }
    }
}
