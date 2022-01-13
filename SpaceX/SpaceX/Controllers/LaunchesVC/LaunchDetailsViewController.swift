//
//  LaunchDetailsViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 14.12.2021.
//

import UIKit

class LaunchDetailsViewController: UIViewController {

    private(set) var scrollView = UIScrollView()
    private var containerForAllViews = UIView()
    private var launchViewModel: LaunchViewModel!

    private lazy var fullScreenImageViewController: FullScreenImageViewController = {
        let viewController = FullScreenImageViewController()

        let tapGestureRecognizre = UITapGestureRecognizer(target: self, action: #selector(fullScreenImageViewTapped))
        viewController.view.addGestureRecognizer(tapGestureRecognizre)

        return viewController
    } ()

    private lazy var tappedCell: LaunchesCollectionViewCell = {
        let cell = LaunchesCollectionViewCell()
        launchViewModel.setUpCell(cell: cell)
        
        guard let logoImageURL = launchViewModel.links.patch.small else { return cell }
        ImageClient.shared.setImage(on: cell.logoView.logoImageView, from: logoImageURL, with: UIImage(named: "launch logo"), complition: nil)
        return cell
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let title = UILabel.descriptionTitleLabel
        title.text = "Description"
        
        let body = UILabel.descriptionBodyLabel
        body.numberOfLines = 0
        body.text = launchViewModel.details
        
        let stack = UIStackView(arrangedSubviews: [title,body])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 20
        
        return stack
    }()
    
    private lazy var overviewStackView: UIView = {
        let view = DetailsView()
        
        view.mainTitle = "Overview"
        
        view.firstLineTitle = "Static fire date"
        view.firstLineValue = launchViewModel.staticFireDateUTC
        
        view.secondLineTitle = "Launch date"
        view.secondLineValue = launchViewModel.dateUTC
        
        view.thirdLineTitle = "Success"
        view.thirdLineValue = launchViewModel.success
        
        return view
    }()
    
    private lazy var launchImagesView: UIView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(OnlyImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel.descriptionTitleLabel
        titleLabel.text = "Images"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let containerView = UIView()
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(collectionView)
        
        launchImagesCollectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 200)
        launchImagesCollectionViewAndTitleDistanceConstraint = titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            launchImagesCollectionViewAndTitleDistanceConstraint!,
            
            launchImagesCollectionViewHeightConstraint!,
            
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }()
    
    private let rocketLabel: UILabel = {
        let label = UILabel.descriptionTitleLabel
        label.text = "Rocket"
        return label
    }()
    
    private lazy var rocketInfoCell: RocketsCollectionViewCell = {
       let cell = RocketsCollectionViewCell()

        guard let rocketViewModel = RocketViewModel.shared.filter({ $0.id == launchViewModel.rocket }).first
        else { return cell }
        
        rocketViewModel.setUpCell(cell: cell)
        
        guard let urlForRocketImage = rocketViewModel.flickrImages.first else { return cell }
        ImageClient.shared.setImage(on: cell.rocketImageView, from: urlForRocketImage, with: UIImage.cellPlaceholderImage, complition: nil)

        return cell
    }()
    
    private lazy var materialsView: LinksView = {
        let linksView = LinksView(titlesAndItsLinks: [("Wikipedia", launchViewModel.links.wikipedia),
                                                      ("Youtube", launchViewModel.links.youtube)], navController: self.navigationController)
        linksView.titleLabel.text = "Materials"
        
        return linksView
    }()
    
    private lazy var redditView: LinksView = {
        let linksView = LinksView(titlesAndItsLinks: [("Campagin", launchViewModel.links.reddit.campaign),
                                                      ("Launch", launchViewModel.links.reddit.launch),
                                                      ("Media", launchViewModel.links.reddit.media),
                                                      ("Recovery", launchViewModel.links.reddit.recovery)], navController: self.navigationController)
        linksView.titleLabel.text = "Reddit"
        return linksView
    }()
    
    // MARK: - constraints
    private var launchImagesCollectionViewHeightConstraint: NSLayoutConstraint?
    private var launchImagesCollectionViewAndTitleDistanceConstraint: NSLayoutConstraint?

    private lazy var launchCellsViewTopConstraint = tappedCell.topAnchor.constraint(equalTo: containerForAllViews.topAnchor,constant: 10)

    // MARK: - public funcs
    func launchCellsFrame() -> CGRect {
        containerForAllViews.convert(tappedCell.frame, to: UIScreen.main.coordinateSpace)
    }

    func setLaunchCellsViewTopInset(to inset: CGFloat) {
        launchCellsViewTopConstraint.constant = inset
    }

    // MARK: - life cycle
    override func viewWillLayoutSubviews() {
        setUpConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        materialsView.setNavigationController(to: navigationController)
        redditView.setNavigationController(to: navigationController)
    }
    
    // MARK: - inits
    init(for launchVM: LaunchViewModel) {
        self.launchViewModel = launchVM
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private funcs
    private func setUpConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        containerForAllViews.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerForAllViews)
        
        tappedCell.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        overviewStackView.translatesAutoresizingMaskIntoConstraints = false
        launchImagesView.translatesAutoresizingMaskIntoConstraints = false
        rocketLabel.translatesAutoresizingMaskIntoConstraints = false
        rocketInfoCell.translatesAutoresizingMaskIntoConstraints = false
        materialsView.translatesAutoresizingMaskIntoConstraints = false
        redditView.translatesAutoresizingMaskIntoConstraints = false

        containerForAllViews.addSubview(tappedCell)
        containerForAllViews.addSubview(descriptionStackView)
        containerForAllViews.addSubview(overviewStackView)
        containerForAllViews.addSubview(launchImagesView)
        containerForAllViews.addSubview(rocketLabel)
        containerForAllViews.addSubview(rocketInfoCell)
        containerForAllViews.addSubview(materialsView)
        containerForAllViews.addSubview(redditView)
        
        let descriptionStackViewTopAnchorConstraint = descriptionStackView.topAnchor.constraint(equalTo: tappedCell.bottomAnchor,constant: 20)
        let launchImagesViewTopAnchorConstraint = launchImagesView.topAnchor.constraint(equalTo: overviewStackView.bottomAnchor, constant: 30)
        let materialsViewTopAnchorConstraint = materialsView.topAnchor.constraint(equalTo: rocketInfoCell.bottomAnchor,constant: 30)
        let redditViewTopAnchorConstraint = redditView.topAnchor.constraint(equalTo: materialsView.bottomAnchor, constant: 30)
        
        tappedCell.cellWidthConstraint.isActive = false

        if launchViewModel.details == "" {
            descriptionStackViewTopAnchorConstraint.constant = 0
            descriptionStackView.spacing = 0
            descriptionStackView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        if launchViewModel.links.flickr.original.count == 0 {
            launchImagesCollectionViewHeightConstraint?.constant = 0
            launchImagesCollectionViewAndTitleDistanceConstraint?.constant = 0
            launchImagesViewTopAnchorConstraint.constant = 0
            launchImagesView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        if launchViewModel.links.wikipedia == nil &&  launchViewModel.links.youtube == nil {
            materialsView.setViewHeightToZero()
            materialsViewTopAnchorConstraint.constant = 0
            materialsView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        if launchViewModel.links.reddit.campaign == nil &&
            launchViewModel.links.reddit.launch == nil &&
            launchViewModel.links.reddit.media == nil &&
            launchViewModel.links.reddit.recovery == nil {
            redditView.setViewHeightToZero()
            redditViewTopAnchorConstraint.constant = 0
            redditView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            containerForAllViews.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerForAllViews.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerForAllViews.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerForAllViews.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            containerForAllViews.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            launchCellsViewTopConstraint,
            tappedCell.leadingAnchor.constraint(equalTo: containerForAllViews.leadingAnchor),
            tappedCell.trailingAnchor.constraint(equalTo: containerForAllViews.trailingAnchor),

            descriptionStackViewTopAnchorConstraint,
            descriptionStackView.leadingAnchor.constraint(equalTo: containerForAllViews.leadingAnchor,constant: 20),
            descriptionStackView.trailingAnchor.constraint(equalTo: containerForAllViews.trailingAnchor,constant: -20),

            overviewStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 30),
            overviewStackView.leadingAnchor.constraint(equalTo: containerForAllViews.leadingAnchor,constant: 20),
            overviewStackView.trailingAnchor.constraint(equalTo: containerForAllViews.trailingAnchor,constant: 20),

            launchImagesViewTopAnchorConstraint,
            launchImagesView.leadingAnchor.constraint(equalTo: containerForAllViews.leadingAnchor,constant: 20),
            launchImagesView.trailingAnchor.constraint(equalTo: containerForAllViews.trailingAnchor,constant: -20),

            rocketLabel.topAnchor.constraint(equalTo: launchImagesView.bottomAnchor,constant: 30),
            rocketLabel.leadingAnchor.constraint(equalTo: containerForAllViews.leadingAnchor,constant: 20),

            rocketInfoCell.topAnchor.constraint(equalTo: rocketLabel.bottomAnchor,constant: 20),
            rocketInfoCell.leadingAnchor.constraint(equalTo: containerForAllViews.leadingAnchor,constant: 20),
            rocketInfoCell.trailingAnchor.constraint(equalTo: containerForAllViews.trailingAnchor,constant: -20),

            rocketInfoCell.heightAnchor.constraint(equalToConstant: rocketCellHeght()),

            materialsViewTopAnchorConstraint,
            materialsView.leadingAnchor.constraint(equalTo: containerForAllViews.leadingAnchor,constant: 20),
            materialsView.trailingAnchor.constraint(equalTo: containerForAllViews.trailingAnchor,constant: -20),

            redditViewTopAnchorConstraint,
            redditView.leadingAnchor.constraint(equalTo: containerForAllViews.leadingAnchor,constant: 20),
            redditView.trailingAnchor.constraint(equalTo: containerForAllViews.trailingAnchor,constant: -20),
            redditView.bottomAnchor.constraint(equalTo: containerForAllViews.bottomAnchor, constant: -40)
        ])
    }
    
    private func rocketCellHeght() -> CGFloat{
        var smallestScreenSize = UIScreen.main.bounds.width > UIScreen.main.bounds.height ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
        smallestScreenSize = smallestScreenSize - 40
        return smallestScreenSize
    }

    @objc private func fullScreenImageViewTapped() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDelegate
extension LaunchDetailsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let launchImageURL = launchViewModel.links.flickr.original[indexPath.item]
        ImageClient.shared.setImage(on: fullScreenImageViewController.fullScreenImageView, from: launchImageURL, with: UIImage.cellPlaceholderImage)

        fullScreenImageViewController.modalPresentationStyle = .fullScreen
        present(fullScreenImageViewController, animated: true, completion: nil)
    }
}

//MARK: -UICollectionViewDataSource
extension LaunchDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchViewModel.links.flickr.original.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return setUpCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func setUpCell(collectionView: UICollectionView, indexPath: IndexPath) -> OnlyImageCollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? OnlyImageCollectionViewCell
        else {fatalError("Cell with identifyer `cell` does not regestered or does not conform to `RocketsCollectionViewCell` type.")}
        
        let launchImageURL = launchViewModel.links.flickr.original[indexPath.item]
        ImageClient.shared.setImage(on: cell.imageView, from: launchImageURL, with: UIImage.cellPlaceholderImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 196)
    }
}
