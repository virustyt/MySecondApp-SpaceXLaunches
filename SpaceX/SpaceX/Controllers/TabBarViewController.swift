//
//  TabBarViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 14.11.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.coral
        tabBar.barTintColor = UIColor.queenBlue
        
        self.setViewControllers([createNavControllerWithTabBarItemForViewController(for: RocketsViewController(), tabBarImageName: "rockets"),
                                 createNavControllerWithTabBarItemForViewController(for: LaunchesViewController(), tabBarImageName: "launches")],
                                animated: true)
    }
    
    private func createNavControllerWithTabBarItemForViewController(for viewController: UIViewController, tabBarImageName: String) -> UINavigationController{

        let navController = SpaceXNavigationController(rootViewController: viewController)
        
        navController.navigationBar.barTintColor = UIColor.queenBlue
        navController.tabBarItem.title = tabBarImageName
        navController.tabBarItem.image = UIImage(named: tabBarImageName)
        navController.tabBarItem.setTitleTextAttributes([.font: UIFont.forTabBarItems,
                                                         .foregroundColor: UIColor.champagne], for: .normal)
        navController.tabBarItem.setTitleTextAttributes([.font: UIFont.forTabBarItems,
                                                         .foregroundColor: UIColor.coral], for: .selected)
        return navController
    }
}
