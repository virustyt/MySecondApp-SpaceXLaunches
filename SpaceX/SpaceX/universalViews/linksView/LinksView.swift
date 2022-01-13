//
//  LinksCollectionView.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 15.12.2021.
//

import UIKit

class LinksView: UIView {
    lazy var collectionViewHeightConstraint = linksCollectionView.heightAnchor.constraint(equalToConstant: 34)
    lazy var titleAndCollectionViewConstraint = titleLabel.bottomAnchor.constraint(equalTo: linksCollectionView.topAnchor, constant: -20)
    
    var titleLabel: UILabel = {
        let label = UILabel.descriptionTitleLabel
        label.text = "Links"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var linksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        
        collectionView.register(LinkCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var urlsByTieles: [(String, URL)]!
    private var navController: UINavigationController?
    
    private var collectionViewHeight = LinkButton.height() 
    
    init(titlesAndItsLinks: [(String, URL?)], navController: UINavigationController?) {
        super.init(frame: .zero)
        let nonNilURLs = titlesAndItsLinks.filter({ $0.1 != nil }).map({ ($0.0,$0.1!) })
        self.urlsByTieles = nonNilURLs
        self.navController = navController
        setUpConstraints()
    }

    // MARK: - public funcs
    func setNavigationController(to navCon: UINavigationController?) {
        self.navController = navCon
    }

    // MARK: - inits
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private funcs
    private func setUpConstraints(){
        addSubview(titleLabel)
        addSubview(linksCollectionView )
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleAndCollectionViewConstraint,
            
            collectionViewHeightConstraint,
            
            linksCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linksCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linksCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setViewHeightToZero(){
        titleAndCollectionViewConstraint.constant = .zero
        collectionViewHeightConstraint.constant = .zero
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension LinksView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 113, height: 32)
    }
}

//MARK: - UICollectionViewDataSource
extension LinksView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urlsByTieles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = linksCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LinkCell
        else { fatalError("cell isnt of type LinkCell") }
        let (title, url) = urlsByTieles[indexPath.item]
        cell.setUpCell(title: title, url: url,navController: navController)
        cell.setNeedsLayout()
        return cell
    }
}

