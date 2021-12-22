//
//  LaunchesCollectionViewCell.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 11.12.2021.
//

import UIKit

class LaunchesCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifyer = String.init(describing: self)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.titleLabelOne
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.forLaunchDate
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var statusImageView: LaunchStatusView = {
        let imageView = LaunchStatusView()
        return imageView
    }()
    
    lazy var launchNumberLabel: LaunchNumberView = {
        let label = LaunchNumberView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var logoView: LogoView = {
        let logoView = LogoView()
        return logoView
    }()
    
    private lazy var titleAndDateStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,dateLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var statusAndLauncNumberStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [statusImageView,launchNumberLabel])
        stack.axis = .horizontal
        stack.spacing = 21
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var finalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleAndDateStack,statusAndLauncNumberStack])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var finalStack2: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [finalStack,logoView])
        stack.axis = .horizontal
        stack.spacing = 60
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //MARK: - constraints
    lazy var cellWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40)
    
    //MARK: - private funcs
    private func setUpConstraints(){
        contentView.addSubview(finalStack2)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([            
            cellWidthConstraint,
            
            logoView.heightAnchor.constraint(lessThanOrEqualTo: logoView.widthAnchor, multiplier: 1),
            logoView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) / 3.42),
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            finalStack2.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            finalStack2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            finalStack2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            finalStack2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
        layer.cornerRadius = 15
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
