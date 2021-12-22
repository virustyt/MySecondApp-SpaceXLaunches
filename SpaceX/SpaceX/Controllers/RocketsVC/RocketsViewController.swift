//
//  AllRocketsViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 03.11.2021.
//

import UIKit

class RocketsViewController: UIViewController {
    
    var networkClient: LaunchesNetProtocol = LaunchesNetClient.shared
    var imageClient: ImageClientProtocol = ImageClient.shared
    var dataTask: URLSessionDataTask?
    var rocketsCollectionView: UICollectionView?
    private var popAnimator = AnimatorViewController()
    var selectedCell: RocketsCollectionViewCell?
    
    var viewModels: [RocketViewModel] =  RocketViewModel.shared 
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .queenBlue
        navigationController?.delegate = self
        setUpCollectionView()
        setUpRefreshControl()
        setUpConstraints()
        setUpNavigationItem()
        refreshData()
    }


    //MARK: - public functions
    @objc func refreshData(){
        guard dataTask == nil else {return}
        self.rocketsCollectionView?.refreshControl?.beginRefreshing()
        dataTask = networkClient.getAllRockets(complition: {[weak self] rockets, error in
//            self?.viewModels = rockets?.map {RocketViewModel(rocket: $0)} ?? []
            RocketViewModel.shared = rockets?.map {RocketViewModel(rocket: $0)} ?? []
            
            self?.dataTask = nil
            self?.rocketsCollectionView?.reloadData()
            
            self?.rocketsCollectionView?.refreshControl?.endRefreshing()
        })
    }
    
    //MARK: - private functions
    private func setUpRefreshControl(){
        let control = UIRefreshControl()
        rocketsCollectionView?.refreshControl = control
        
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        control.attributedTitle = NSAttributedString(string: "Loading...")
    }
    
    private func setUpCollectionView(){
        rocketsCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        rocketsCollectionView?.delegate = self
        rocketsCollectionView?.dataSource = self
        rocketsCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        rocketsCollectionView?.register(RocketsCollectionViewCell.self, forCellWithReuseIdentifier: RocketsCollectionViewCell.identifyer)
        rocketsCollectionView?.backgroundColor = UIColor.queenBlue
    }
    
    private func setUpConstraints(){
        guard let collectionViewWithRockets = rocketsCollectionView else {return}
        self.view.addSubview(collectionViewWithRockets)
        NSLayoutConstraint.activate([
            collectionViewWithRockets.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionViewWithRockets.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionViewWithRockets.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionViewWithRockets.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setUpNavigationItem(){
        let sortBarButtonItem = UIBarButtonItem(image: UIImage(named: "button-sort"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(showSortViewController))
        sortBarButtonItem.tintColor = UIColor.coral
        navigationItem.rightBarButtonItem = sortBarButtonItem
    }
    
    @objc private func showSortViewController(){
        let popUpSortController = SortViewController(forViewModelKind: .rockets(controller: self))
        popUpSortController.modalPresentationStyle = .overCurrentContext
        popUpSortController.modalTransitionStyle = .coverVertical
        showDetailViewController(popUpSortController, sender: self)
    }
}



//MARK: - DelegateFlowLayout
extension RocketsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let smallestSideOfViewSize = view.frame.width >= view.frame.height ? view.frame.height : view.frame.width
        
        return sizes.makeItemSize(from: smallestSideOfViewSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sizes.minLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sizes.minInteritemSpacing
    }
    
    enum sizes {
        static let minLineSpacing: CGFloat = 30
        static let minInteritemSpacing: CGFloat = 18
        static func makeItemSize(from smallestViewSide: CGFloat) -> CGSize{
            return CGSize(width: smallestViewSide - minInteritemSpacing * 2,
                          height: (smallestViewSide - minInteritemSpacing * 2) * 0.9)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath) as? RocketsCollectionViewCell
        
        let viewModelOfSelectedCell = RocketViewModel.shared[indexPath.item]
        let detailsVC = RocketDetailsViewController(for: viewModelOfSelectedCell)

        detailsVC.hidesBottomBarWhenPushed = true

        navigationItem.backBarButtonItem = UIBarButtonItem(image: nil,
                                                           style: .done,
                                                                     target: nil,
                                                                     action: nil)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}



//MARK: - DataSource
extension RocketsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        RocketViewModel.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return rocketCell(tableView: collectionView, indexPath: indexPath)
    }
    
    private func rocketCell(tableView: UICollectionView, indexPath: IndexPath) -> RocketsCollectionViewCell{
        guard let cell = rocketsCollectionView?.dequeueReusableCell(withReuseIdentifier: RocketsCollectionViewCell.identifyer, for: indexPath) as? RocketsCollectionViewCell
        else { fatalError("dequed cell isnt of class RocketsCollectionViewCell.") }
        let viewModel = RocketViewModel.shared[indexPath.item]
        viewModel.setUpCell(cell: cell)
        
        if let urlForRocketImage = viewModel.flickrImages.first {
            self.imageClient.setImage(on: cell.rocketImageView,
                                      from: urlForRocketImage,
                                      with: UIImage.cellPlaceholderImage,
                                      complition: nil)
        }
        return cell
    }
}


//MARK: - UINavigationControllerDelegate
extension RocketsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            popAnimator.presenting = false
        case .push:
            selectedCell?.alpha = 0
            if let cellsFrame = selectedCell?.frame {
                popAnimator.originFrame =  rocketsCollectionView?.convert(cellsFrame, to: UIScreen.main.coordinateSpace)
            }
            popAnimator.presenting = true
        default:
            break
        }
        return popAnimator
    }
}
