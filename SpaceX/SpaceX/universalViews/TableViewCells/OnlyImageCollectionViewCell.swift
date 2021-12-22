//
//  RocketsDetailCollectionViewCell.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 18.11.2021.
//

import UIKit

class OnlyImageCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
        layer.cornerRadius = 10
        layer.setUpShadows(withShadowCornerRadius: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3)
        ])
    }
}
