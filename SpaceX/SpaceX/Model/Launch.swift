//
//  Launches.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 02.11.2021.
//

import Foundation

// MARK: - Launch
struct Launch: Codable,Equatable {
    let links: Links
    let staticFireDateUTC: String
    let rocket: String
    let success: Bool
    let details: String
    let name: String
    let dateUTC: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case links
        case staticFireDateUTC = "static_fire_date_utc"
        case rocket, success, details
        case name
        case dateUTC = "date_utc"
        case id
    }
}

// MARK: - Links
struct Links: Codable,Equatable {
    let patch: Patch
    let reddit: Reddit
    let flickr: Flickr
    let presskit: String
    let webcast: String
    let youtubeID: String
    let article, wikipedia: String

    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, presskit, webcast
        case youtubeID = "youtube_id"
        case article, wikipedia
    }
}

// MARK: - Flickr
struct Flickr: Codable, Equatable {
    let small: [String]
    let original: [String]
}

// MARK: - Patch
struct Patch: Codable, Equatable {
    let small, large: String?
}

// MARK: - Reddit
struct Reddit: Codable, Equatable {
    let campaign, launch, media: String
    let recovery: String?
}


