//
//  MockLaunchesPatchProtocol.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 03.11.2021.
//

import Foundation
@testable import SpaceX

class MockLaunchesNetClient: LaunchesNetProtocol{
    var getAllRocketsCalls = 0
    var complition: (([Rocket]?,Error?) -> ())!
    var dummyDataTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: "dummy")!)
    
    func getAllRockets(complition: @escaping ([Rocket]?, Error?) -> ()) -> URLSessionDataTask? {
        getAllRocketsCalls += 1
        self.complition = complition
        return dummyDataTask
    }
}
