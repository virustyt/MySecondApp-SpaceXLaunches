//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 14.11.2021.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    private var netClient: LaunchesNetProtocol = LaunchesNetClient.shared
    private var dataTask: URLSessionDataTask?
    private let imageClient: ImageClientProtocol = ImageClient.shared
    var selectedCell: LaunchesCollectionViewCell?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        return refreshControl
    }()

    lazy var launchesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        collectionView.backgroundColor = .queenBlue
        
        collectionView.register(LaunchesCollectionViewCell.self, forCellWithReuseIdentifier: LaunchesCollectionViewCell.reuseIdentifyer)
        
        return collectionView
    }()
    
//    private var viewModels: [LaunchViewModel] = LaunchViewModel.shared
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        setUpNavigationItem()
        refresh()
    }
    
    //MARK: - private functions
    private func setUpNavigationItem(){
        let sortBarButtonItem = UIBarButtonItem(image: UIImage(named: "button-sort"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(showSortViewController))
        sortBarButtonItem.tintColor = UIColor.coral
        navigationItem.rightBarButtonItem = sortBarButtonItem
    }
    
    @objc private func showSortViewController(){
        let popUpSortController = SortViewController(forViewModelKind: .launches(controller: self))
        popUpSortController.modalPresentationStyle = .overCurrentContext
        popUpSortController.modalTransitionStyle = .coverVertical
        showDetailViewController(popUpSortController, sender: self)
    }
    
    private func setUpConstraints(){
        view.addSubview(launchesCollectionView)
        NSLayoutConstraint.activate([
            launchesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            launchesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            launchesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            launchesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    
    @objc private func refresh(){
        guard dataTask == nil else { return }
        launchesCollectionView.refreshControl?.beginRefreshing()
        
        dataTask = netClient.getAllLaunches(complition: { [weak self] recievedLaunches, error in
            guard let self = self,
                  let arrayOfLaunches = recievedLaunches else {return}
            LaunchViewModel.shared = arrayOfLaunches.map { LaunchViewModel($0) }
            self.launchesCollectionView.refreshControl?.endRefreshing()
            self.dataTask = nil
            self.launchesCollectionView.reloadData()
        })
    }
}

extension LaunchesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { sizes.interItemSpacing }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { sizes.interLineSpacing }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let smallestViewSideSize = view.frame.width > view.frame.height ? view.frame.height : view.frame.width
        return sizes.makeItemSize(from: smallestViewSideSize)
    }
    
    enum sizes{
        static let interItemSpacing: CGFloat = 20
        static let interLineSpacing: CGFloat = 30
        static func makeItemSize(from smallestViewSideSize: CGFloat) -> CGSize{
            return CGSize(width: smallestViewSideSize - interItemSpacing * 2,
                          height: (smallestViewSideSize - interItemSpacing * 2) / 2.6)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath) as? LaunchesCollectionViewCell
        
        let viewModelOfSelectedCell = LaunchViewModel.shared[indexPath.item]
        let detailsVC = LaunchDetailsViewController(for: viewModelOfSelectedCell)

        detailsVC.hidesBottomBarWhenPushed = true

        navigationItem.backBarButtonItem = UIBarButtonItem(image: nil,
                                                           style: .done,
                                                                     target: nil,
                                                                     action: nil)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension LaunchesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        LaunchViewModel.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCollectionViewCell.reuseIdentifyer, for: indexPath) as? LaunchesCollectionViewCell
        else { fatalError("Dequed cell isnt of class LaunchesCollectionViewCell.")}
        
        let viewModel = LaunchViewModel.shared[indexPath.item]
        viewModel.setUpCell(cell: cell)
        
        guard let logoImageURL = viewModel.links.patch.small else { return cell }
        imageClient.setImage(on: cell.logoView.logoImageView, from: logoImageURL, with: UIImage(named: "launch logo"), complition: nil)
        return cell
    }
}
