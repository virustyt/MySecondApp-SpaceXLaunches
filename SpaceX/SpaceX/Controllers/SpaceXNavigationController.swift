//
//  SpaceXNavigationController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 21.11.2021.
//

import UIKit

class SpaceXNavigationController: UINavigationController {

    override var childForStatusBarHidden: UIViewController?{
        return topViewController
    }
}
