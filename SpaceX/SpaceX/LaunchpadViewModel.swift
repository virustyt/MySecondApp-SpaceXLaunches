//
//  LaunchpadViewModel.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 02.11.2021.
//

import Foundation

struct  LaunchpadViewModel {
    var launchpad: Launchpad
    let name: String
    let fullName: String
    let locality: String
    let region: String
    let latitude: Double
    let longitude: Double
    let launchAttempts: Int
    let launchSuccesses: Int
    let rocketImages: [String]
    let launcheImages: [String]
    let status: String
    let id: String
    
    init (_ launchpad: Launchpad){
        self.launchpad = launchpad
        self.name = launchpad.name
        self.fullName = launchpad.fullName
        self.locality = launchpad.locality
        self.region = launchpad.region
        self.latitude = launchpad.latitude
        self.longitude = launchpad.longitude
        self.launchAttempts = launchpad.launchAttempts
        self.launchSuccesses = launchpad.launchSuccesses
        self.rocketImages = launchpad.rocketImages
        self.launcheImages = launchpad.launcheImages
        self.status = launchpad.status
        self.id = launchpad.id
    }
}
