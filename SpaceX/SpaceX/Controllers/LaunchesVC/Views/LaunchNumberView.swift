//
//  LaunchNumberView.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 14.12.2021.
//

import UIKit

class LaunchNumberView: UIView {

    private let launchNumberLabel = UILabel()
    let containerForLabelView = UIView()
    var text: String? {
        didSet{
            launchNumberLabel.text = text
        }
    }
    private var haveShadows = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerForLabelView.backgroundColor = .white
        launchNumberLabel.textColor = UIColor.cyanProcess
        launchNumberLabel.font = UIFont.forLaunchDate
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(containerForLabelView)
        containerForLabelView.addSubview(launchNumberLabel)
        launchNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        containerForLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerForLabelView.topAnchor.constraint(equalTo: topAnchor),
            containerForLabelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerForLabelView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerForLabelView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            launchNumberLabel.topAnchor.constraint(equalTo: containerForLabelView.topAnchor,constant: 5),
            launchNumberLabel.leadingAnchor.constraint(equalTo: containerForLabelView.leadingAnchor,constant: 10),
            launchNumberLabel.trailingAnchor.constraint(equalTo: containerForLabelView.trailingAnchor,constant: -10),
            launchNumberLabel.bottomAnchor.constraint(equalTo: containerForLabelView.bottomAnchor,constant: -5)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if text != nil, !haveShadows {
            layer.cornerRadius = 15
            layer.setUpShadows(withShadowCornerRadius: 15)
            containerForLabelView.layer.cornerRadius = 15
            containerForLabelView.layer.masksToBounds = true
            haveShadows = true
        }
    }
}
