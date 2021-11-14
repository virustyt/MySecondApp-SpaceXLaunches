//
//  AllRocketsableViewCell.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 11.11.2021.
//

import UIKit

class RocketsTableViewCell: UITableViewCell {
    
    static let identifyer: String = String(describing: self)
    
    var rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var rocketNameValueLabel = UILabel.titleLabelOne
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
        rocketInfoStack.distribution = .fillEqually
        
        let summaryStack = UIStackView(arrangedSubviews: [rocketNameValueLabel,rocketInfoStack])
        summaryStack.axis = .vertical
        summaryStack.alignment = .leading
        summaryStack.distribution = .equalSpacing
        summaryStack.spacing = 27
        
        return summaryStack
    }()
    
    private lazy var finalStack: UIStackView = {
        
        let stack = UIStackView(arrangedSubviews: [rocketImageView,summaryInfoStack])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.alignment = .fill
        return stack
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        contentView.addSubview(finalStack)
        rocketImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: finalStack.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: finalStack.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: finalStack.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: finalStack.trailingAnchor)
        ])
    }
}
