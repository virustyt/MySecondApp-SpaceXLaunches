//
//  RocketDetailViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 18.11.2021.
//

import UIKit

class RocketDetailViewController: UIViewController {
    
    private var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private var rocketViewModel: RocketViewModel
    
    private lazy var rocketImages: [Int: UIImage] = {
        let arrrayOfImages = [Int: UIImage]()
        
        return arrrayOfImages
    }()

    private lazy var rocketImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        guard let urlForFirstRocketImage = rocketViewModel.flickrImages.first else { return image }
        ImageClient.shared.setImage(on: image, from: urlForFirstRocketImage, with: UIImage.cellPlaceholderImage)
        return image
    }()
    
    private lazy var rocketNameLabel: UILabel = {
        let label = UILabel()
        label.text = rocketViewModel.name
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 42)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionStack: UIStackView = {
        let descriptionTitleLabel = UILabel.descriptionTitleLabel
        descriptionTitleLabel.text = "Description"
        
        let descriptionBodyLabel = UILabel.descriptionBodyLabel
        descriptionBodyLabel.text = rocketViewModel.welcomeDescription
        descriptionBodyLabel.numberOfLines = 0
        
        let stack = UIStackView(arrangedSubviews: [descriptionTitleLabel, descriptionBodyLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 20

        return stack
    }()
    
    private lazy var overview: UIView = {
        let detailsList = DetailsView()
        detailsList.mainTitle = "Overview"
        
        detailsList.firstLineTitle = "First launch"
        detailsList.firstLineVslue = rocketViewModel.firstFlight
        
        detailsList.secondLineTitle = "Launch cost"
        detailsList.secondLineValue = rocketViewModel.costPerLaunch
        
        detailsList.thirdLineTitle = "Success"
        detailsList.thirdLineValue = rocketViewModel.successRatePct
        
        detailsList.thourthLineTitle = "Mass"
        detailsList.thourthLineValue = rocketViewModel.mass
        
        detailsList.fifthLineTitle = "Height"
        detailsList.fifthLineValue = rocketViewModel.height
        
        detailsList.sixthLineTitletitle = "Diameter"
        detailsList.sixthLineValue = rocketViewModel.diameter
        

        return detailsList
    }()

    private lazy var ImagesStack: UIView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(RocketsDetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel.descriptionTitleLabel
        titleLabel.text = "Images"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }()
    
    private lazy var enginesView: UIView = {
        let detailsList = DetailsView()
        detailsList.mainTitle = "Engines"
        
        detailsList.firstLineTitle = "Type"
        detailsList.firstLineVslue = rocketViewModel.engines.type
        
        detailsList.secondLineTitle = "Layout"
        detailsList.secondLineValue = rocketViewModel.engines.layout
        
        detailsList.thirdLineTitle = "Version"
        detailsList.thirdLineValue = rocketViewModel.engines.version
        
        detailsList.thourthLineTitle = "Amount"
        detailsList.thourthLineValue = rocketViewModel.engines.number
        
        detailsList.fifthLineTitle = "Propellant 1"
        detailsList.fifthLineValue = rocketViewModel.engines.propellant1
        
        detailsList.sixthLineTitletitle = "Propellant 2"
        detailsList.sixthLineValue = rocketViewModel.engines.propellant2
        
        return detailsList
    }()
    
    private lazy var firstStageView: UIView = {
        let detailsList = DetailsView()
        detailsList.mainTitle = "First stage"
        
        detailsList.firstLineTitle = "Reusable"
        detailsList.firstLineVslue = rocketViewModel.firstStage.reusable
        
        detailsList.secondLineTitle = "Engines amaount"
        detailsList.secondLineValue = rocketViewModel.firstStage.engines
        
        detailsList.thirdLineTitle = "Fuel amount"
        detailsList.thirdLineValue = rocketViewModel.firstStage.fuelAmountTons
        
        detailsList.thourthLineTitle = "Burning time"
        detailsList.thourthLineValue = rocketViewModel.firstStage.burnTimeSEC
        
        detailsList.fifthLineTitle = "Thurst (sea level)"
        detailsList.fifthLineValue = rocketViewModel.firstStage.thrustSeaLevel
        
        detailsList.sixthLineTitletitle = "Thrust (vacuum)"
        detailsList.sixthLineValue = rocketViewModel.firstStage.thrustVacuum
        

        return detailsList
    }()
    
    private lazy var secondStageView: UIView = {
        let detailsList = DetailsView()
        detailsList.mainTitle = "Second stage"
        
        detailsList.firstLineTitle = "Reusable"
        detailsList.firstLineVslue = rocketViewModel.secondStage.reusable
        
        detailsList.secondLineTitle = "Engines amaount"
        detailsList.secondLineValue = rocketViewModel.secondStage.engines
        
        detailsList.thirdLineTitle = "Fuel amount"
        detailsList.thirdLineValue = rocketViewModel.secondStage.fuelAmountTons
        
        detailsList.thourthLineTitle = "Burning time"
        detailsList.thourthLineValue = rocketViewModel.secondStage.burnTimeSEC
        
        detailsList.fifthLineTitle = "Thurst"
        detailsList.fifthLineValue = rocketViewModel.secondStage.thrust

        return detailsList
    }()
    
    private lazy var landingLegsView: UIView = {
        let detailsList = DetailsView()
        detailsList.mainTitle = "Landing legs"
        
        detailsList.firstLineTitle = "Amount"
        detailsList.firstLineVslue = rocketViewModel.landingLegs.number
        
        detailsList.secondLineTitle = "Material"
        detailsList.secondLineValue = rocketViewModel.landingLegs.material

        return detailsList
    }()
    
    private lazy var materialsView: UIStackView = {
        let label = UILabel.descriptionTitleLabel
        label.text = "Materials"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let wikiLinkButton = LinkView(title: "Materials", actionForTap: {})
        wikiLinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [label, wikiLinkButton])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        stack.alignment = .leading

        return stack
    }()
    
    private lazy var topSummaryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [descriptionStack, overview])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 30
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    private lazy var bottomSummaryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [enginesView, firstStageView, secondStageView, landingLegsView, materialsView])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 30
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.setBackIndicatorImage(UIImage(named: "button right")!, transitionMaskImage: UIImage(named: "button right")!)

        navigationItem.compactAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.standardAppearance = appearance
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLayoutSubviews() {
        setUpConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.queenBlue

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    //MARK: - inits
    init(for rocketVM: RocketViewModel) {
        self.rocketViewModel = rocketVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private funcs
    private func setUpConstraints(){
        view.addSubview(scrollView)

        scrollView.addSubview(rocketImage)
        scrollView.addSubview(topSummaryStack)
        scrollView.addSubview(ImagesStack)
        scrollView.addSubview(bottomSummaryStack)
        
        rocketImage.addSubview(rocketNameLabel)
        
        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo:  view.topAnchor ),
            scrollView.topAnchor.constraint(equalTo:  view.topAnchor,constant: -view.safeAreaInsets.top ),
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor,
//                                            constant: -(  view.frame.height - view.safeAreaLayoutGuide.layoutFrame.height) ),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rocketNameLabel.bottomAnchor.constraint(equalTo: rocketImage.bottomAnchor, constant: -30),
            rocketNameLabel.leadingAnchor.constraint(equalTo: rocketImage.leadingAnchor, constant: 20),
            
            rocketImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rocketImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            rocketImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            rocketImage.heightAnchor.constraint(equalTo: rocketImage.widthAnchor, multiplier: 0.8),
            
            topSummaryStack.topAnchor.constraint(equalTo: rocketImage.bottomAnchor,constant: 40),
            topSummaryStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            topSummaryStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            topSummaryStack.bottomAnchor.constraint(equalTo: ImagesStack.topAnchor,constant: -30),
            
            ImagesStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            ImagesStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            bottomSummaryStack.topAnchor.constraint(equalTo: ImagesStack.bottomAnchor,constant: 40),
            bottomSummaryStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            bottomSummaryStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            bottomSummaryStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -25)
        ])
    }
    
}


//MARK: - UICollectionViewDelegate
extension RocketDetailViewController: UICollectionViewDelegateFlowLayout {
    
}

//MARK: -UICollectionViewDataSource
extension RocketDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rocketViewModel.flickrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return setUpCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func setUpCell(collectionView: UICollectionView, indexPath: IndexPath) -> RocketsDetailCollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RocketsDetailCollectionViewCell
        else {fatalError("Cell with identifyer `cell` does not regestered or does not conform to `RocketsCollectionViewCell` type.")}
        
        let rocketImageURL = rocketViewModel.flickrImages[indexPath.item]
        ImageClient.shared.setImage(on: cell.rocketImageView, from: rocketImageURL, with: UIImage.cellPlaceholderImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 196)
    }
}
