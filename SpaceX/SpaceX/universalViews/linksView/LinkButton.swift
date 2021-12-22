//
//  LinkButton.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 15.12.2021.
//

import UIKit

class LinkButton: UIButton {

    var title: String = "title"{
        didSet{
            linkTitleLabel.text = title
            widthConstraint.constant = linkTitleLabel.intrinsicContentSize.width + (linkImageView.image?.size.width ?? 0) + 30
        }
    }

    private lazy var widthConstraint =  widthAnchor.constraint(equalToConstant: linkTitleLabel.intrinsicContentSize.width + (linkImageView.image?.size.width ?? 0) + 30)
    
    private let linkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "button-link") ?? UIImage())
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var linkTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 17) ?? UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.coral
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setUpConstraints(){
        addSubview(linkImageView)
        addSubview(linkTitleLabel)
        
        NSLayoutConstraint.activate([
            widthConstraint,
            heightAnchor.constraint(equalToConstant: linkTitleLabel.intrinsicContentSize.height + 10),
            
            linkTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            linkTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            linkTitleLabel.trailingAnchor.constraint(equalTo: linkImageView.leadingAnchor,constant: 7.5),
            
            linkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            linkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12.5)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func height() -> CGFloat {
        let testButton = LinkButton(frame: .zero)
        testButton.setNeedsLayout()
        return 32//testButton.frame.size.height
    }
}
