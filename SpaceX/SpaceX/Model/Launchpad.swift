//
//  RocketModel.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 19.10.2021.
//

import Foundation

//        let name, fullName, locality, region: String
//        let timezone: String
//        let latitude, longitude: Double
//        let launchAttempts, launchSuccesses: Int
//        let rockets, launches: [String]
//        let status, id: String

struct  Launchpad: Codable {
    let name: String
    let fullName: String
    let locality: String
    let region: String
    let timeZoneIdentifyer: String
    let latitude: Double
    let longitude: Double
    let launchAttempts: Int
    let launchSuccesses: Int
    let rocketImages: [String]
    let launcheImages: [String]
    let status: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case timeZoneIdentifyer = "timezone"
        case locality, region, latitude, longitude
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
        case rocketImages = "rockets"
        case launcheImages = "launches"
        case status, id
    }
}
