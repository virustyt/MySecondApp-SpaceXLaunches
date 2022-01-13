//
//  LinkView.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 20.11.2021.
//

import UIKit

class LinkCell: UICollectionViewCell {

    private let button:LinkButton!
    private var hsveShadows = false
    private var linkURL: URL?
    private var navController: UINavigationController?

    override init(frame: CGRect) {
        button = LinkButton(frame: .zero)
        super.init(frame: .zero)

        button?.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        button?.backgroundColor = .white

        setUpConstraints()
    }
    
    //MARK: - public funcs
    func setUpCell(title: String, url: URL, navController: UINavigationController?){
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        button.title = title
        self.linkURL = url
        self.navController = navController
        
    }
    
    //MARK: - private funcs
    private func setUpConstraints(){
        guard let linkButton = button else {return}
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(linkButton)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            linkButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            linkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            linkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            linkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func buttonTouched(){
        guard let url = linkURL else { return }
        let webKitVC = WKViewController(url: url, title: button.title)
    
        navController?.pushViewController(webKitVC, animated: true)
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
