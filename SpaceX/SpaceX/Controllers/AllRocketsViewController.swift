//
//  AllRocketsViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 03.11.2021.
//

import UIKit

class AllRocketsViewController: UIViewController {
    
    var networkClient: LaunchesNetProtocol = LaunchesNetClient.shared
    var dataTask: URLSessionDataTask?
    var tableView: UITableView?
    var tableViewController: UITableViewController?
    
    var viewModels: [RocketViewModel] = []

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView()
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
}
