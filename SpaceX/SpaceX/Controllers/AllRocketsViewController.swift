//
//  AllRocketsViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 03.11.2021.
//

import UIKit

class AllRocketsViewController: UIViewController {
    
    var networkClient: LaunchesNetProtocol = LaunchesNetClient.shared
    var imageClient: ImageClientProtocol = ImageClient.shared
    var dataTask: URLSessionDataTask?
    var tableView: UITableView?
    var tableViewController: UITableViewController?
    
    var viewModels: [RocketViewModel] = []

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpRefreshControl()
        tableView?.delegate = tableViewController
    }

    //MARK: - public functions
    @objc func refreshData(){
        guard dataTask == nil else {return}
        self.tableView?.refreshControl?.beginRefreshing()
        dataTask = networkClient.getAllRockets(complition: {[weak self] rockets, error in
            self?.viewModels = rockets?.map {RocketViewModel(rocket: $0)} ?? []
            self?.dataTask = nil
            self?.tableView?.reloadData()
            
            self?.tableView?.refreshControl?.endRefreshing()
        })
        
    }
    
    //MARK: - private functions
    private func setUpRefreshControl(){
        let control = UIRefreshControl()
        tableView?.refreshControl = control
        
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        control.attributedTitle = NSAttributedString(string: "Loading...")
    }
    
    private func setUpTableView(){
        self.tableView = UITableView()
        self.tableView?.register(RocketsTableViewCell.self, forCellReuseIdentifier: RocketsTableViewCell.identifyer)
    }
}

extension AllRocketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let neededCell = rocketCell(tableView: tableView, indexPath: indexPath)
        return neededCell
    }
    
    private func rocketCell(tableView: UITableView, indexPath: IndexPath) -> RocketsTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: RocketsTableViewCell.identifyer) as! RocketsTableViewCell
        let viewModel = viewModels[indexPath.item]
        viewModel.setUpCell(cell: cell)
        
        if let urlForRocketImage = viewModel.flickrImages.first {
            self.imageClient.setImage(on: cell.rocketImageView,
                                      from: urlForRocketImage,
                                      with: UIImage(named: "cat"),
                                      complition: nil)
        }
        return cell
    }
}
