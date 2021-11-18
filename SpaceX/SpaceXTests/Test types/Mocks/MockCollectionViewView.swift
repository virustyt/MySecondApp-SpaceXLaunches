//
//  MockTableView.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 03.11.2021.
//

import UIKit

class MockCollectionViewView: UICollectionView{
    var reloadDataCalled = false
    override func reloadData() {
        reloadDataCalled = true
    }
}
