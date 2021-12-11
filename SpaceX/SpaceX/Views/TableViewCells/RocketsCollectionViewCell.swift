//
//  AllRocketsableViewCell.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 11.11.2021.
//

import UIKit

class RocketsCollectionViewCell: UICollectionViewCell {
    
    static let identifyer: String = String(describing: self)
    
    lazy var rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var rocketTitleLabel: UILabel = {
        let label = UILabel.titleLabelOne
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    var rocketTitleLabel = UILabel.titleLabelOne
    var firstLaunchValueLabel = UILabel.bodyLabel
    var localCostValueLabel = UILabel.bodyLabel
    var sucsessPrecentsValueLabel = UILabel.bodyLabel
    
    private var firstLauhchLabel: UILabel = {
        let label = UILabel.titleLabelTwo
        label.text = "First launch"
        return label
    }()
    private var localCostLabel: UILabel = {
        let label = UILabel.titleLabelTwo
        label.text = "Launch cost"
        return label
    }()
    private var sucsessPrecentsLabel: UILabel = {
        let label = UILabel.titleLabelTwo
        label.text = "Success"
        return label
    }()
    
    private lazy var summaryInfoStack: UIStackView = {
        let firstLaunchStack = UIStackView(arrangedSubviews: [firstLauhchLabel,firstLaunchValueLabel])
        firstLaunchStack.axis = .vertical
        firstLaunchStack.alignment = .leading
        
        let localCostStack = UIStackView(arrangedSubviews: [localCostLabel,localCostValueLabel])
        localCostStack.axis = .vertical
        localCostStack.alignment = .leading
        
        let sucsessPrecentsStack = UIStackView(arrangedSubviews: [sucsessPrecentsLabel,sucsessPrecentsValueLabel])
        sucsessPrecentsStack.axis = .vertical
        sucsessPrecentsStack.alignment = .leading
        
        let rocketInfoStack = UIStackView(arrangedSubviews: [firstLaunchStack,localCostStack,sucsessPrecentsStack])
        rocketInfoStack.axis = .horizontal
        rocketInfoStack.distribution = .equalSpacing
        rocketInfoStack.spacing = 10
        
        rocketInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        return rocketInfoStack
    }()
    
    //MARK: - constraints
    lazy var rocketTitleLabelTopAnchorConstraint = rocketTitleLabel.topAnchor.constraint(equalTo: rocketImageView.bottomAnchor, constant: 10)
    lazy var rocketTitleLabelLeadingAnchorConstraint = rocketTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
    
    //MARK: - inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
        setUpShadows()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private funcs
    private func setUpShadows(){
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.37
    }
    
    private func setUpConstraints(){
        contentView.addSubview(rocketImageView)
        contentView.addSubview(summaryInfoStack)
        contentView.addSubview(rocketTitleLabel)
        
        rocketImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        rocketTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        summaryInfoStack.setContentCompressionResistancePriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            rocketImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rocketImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rocketImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            rocketTitleLabelTopAnchorConstraint,
            rocketTitleLabelLeadingAnchorConstraint,
            
            summaryInfoStack.topAnchor.constraint(equalTo: rocketTitleLabel.bottomAnchor, constant: 27),
            summaryInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            summaryInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -59),
            summaryInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -21)
        ])
    }
}
