//
//  LinkView.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 20.11.2021.
//

import UIKit

class LinkView: UIView {

    private let actionOnTap: ()->()?
    private let button:UIButton?
    private var hsveShadows = false
    
    init(title: String, actionForTap: @escaping ()->()){
        button = UIButton.setUpTolinkButton(withTitle: title)
        actionOnTap = actionForTap
        super.init(frame: button?.frame ?? .zero)
        
        button?.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        button?.backgroundColor = .white
        
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        guard let linkButton = button else {return}
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(linkButton)
        NSLayoutConstraint.activate([
            linkButton.topAnchor.constraint(equalTo: topAnchor),
            linkButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func buttonTouched(){
        actionOnTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !hsveShadows {
            layer.cornerRadius = frame.size.height / 2
            layer.setUpShadows(withShadowCornerRadius: frame.size.height / 2)
            button?.layer.cornerRadius = frame.size.height / 2
            
            hsveShadows = true
        }
    }
}
