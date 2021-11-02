//
//  LaunchesTests.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 02.11.2021.
//

// MARK: - Launch
//struct Launch: Codable,Equatable {
//    let links: Links
//    let staticFireDateUTC: String
//    let rocket: String
//    let success: Bool
//    let details: String
//    let name: String
//    let dateUTC: String
//    let id: String
//
//    enum CodingKeys: String, CodingKey {
//        case links
//        case staticFireDateUTC = "static_fire_date_utc"
//        case rocket, success, details
//        case name
//        case dateUTC = "date_utc"
//        case id
//    }
//}
//
//// MARK: - Links
//struct Links: Codable,Equatable {
//    let patch: Patch
//    let reddit: Reddit
//    let flickr: Flickr
//    let presskit: String
//    let webcast: String
//    let youtubeID: String
//    let article, wikipedia: String
//
//    enum CodingKeys: String, CodingKey {
//        case patch, reddit, flickr, presskit, webcast
//        case youtubeID = "youtube_id"
//        case article, wikipedia
//    }
//}
//
//// MARK: - Flickr
//struct Flickr: Codable, Equatable {
//    let small: [String]
//    let original: [String]
//}
//
//// MARK: - Patch
//struct Patch: Codable, Equatable {
//    let small, large: String?
//}
//
//// MARK: - Reddit
//struct Reddit: Codable, Equatable {
//    let campaign, launch, media: String
//    let recovery: String?
//}


import XCTest
@testable import SpaceX

class LaunchTests: XCTestCase, DecodableTestCase {
    var dictionary: NSDictionary!
    var sut: Launch!

    override func setUp() {
        super.setUp()
        try! givenSutFromJSON()
    }
    
    //MARK: Type tests
    func test_Launch_isDecodable(){
        XCTAssert((sut as Any) is Decodable)
    }
    
    func test_Launch_isEquatable(){
        XCTAssertEqual(sut, sut)
    }
    
    //MARK: Decodable tests
    func test_decodable_setLinks() throws {
        //given
        let givenLinks = try XCTUnwrap(dictionary["links"] as? Dictionary<String, Any>)
        let givenPatch = try XCTUnwrap(givenLinks["patch"] as? Dictionary<String, Any>)
        let givenReddit = try XCTUnwrap(givenLinks["reddit"] as? Dictionary<String, Any>)
        let givenFlickr = try XCTUnwrap(givenLinks["flickr"] as? Dictionary<String, Any>)
        //then
        try XCTassertEqualsToAny(sut.links.patch.large, givenPatch["large"])
        try XCTassertEqualsToAny(sut.links.patch.small, givenPatch["small"])

        try XCTassertEqualsToAny(sut.links.reddit.campaign, givenReddit["campaign"])
        try XCTassertEqualsToAny(sut.links.reddit.launch, givenReddit["launch"])
        try XCTassertEqualsToAny(sut.links.reddit.media, givenReddit["media"])
        try XCTassertEqualsToAny(sut.links.reddit.recovery, givenReddit["recovery"])
        
        try XCTassertEqualsToAny(sut.links.flickr.original, givenFlickr["original"])
        try XCTassertEqualsToAny(sut.links.flickr.small, givenFlickr["small"])

        try XCTassertEqualsToAny(sut.links.presskit, givenLinks["presskit"])
        try XCTassertEqualsToAny(sut.links.webcast, givenLinks["webcast"])
        try XCTassertEqualsToAny(sut.links.article, givenLinks["article"])
        try XCTassertEqualsToAny(sut.links.youtubeID, givenLinks["youtube_id"])
        try XCTassertEqualsToAny(sut.links.wikipedia, givenLinks["wikipedia"])
    }

    func test_decodable_setStaticFireDateUTC() throws {
        try XCTassertEqualsToAny(sut.staticFireDateUTC, dictionary["static_fire_date_utc"])
    }
    
    func test_decodable_setRocket() throws {
        try XCTassertEqualsToAny(sut.rocket, dictionary["rocket"])
    }
    
    func test_decodable_setSuccess() throws {
        try XCTassertEqualsToAny(sut.success, dictionary["success"])
    }
    
    func test_decodable_setDetails() throws {
        try XCTassertEqualsToAny(sut.details, dictionary["details"])
    }
    
    func test_decodable_setName() throws {
        try XCTassertEqualsToAny(sut.name, dictionary["name"])
    }
    
    func test_decodable_setDateUTC() throws {
        try XCTassertEqualsToAny(sut.dateUTC, dictionary["date_utc"])
    }
    
    func test_decodable_setId() throws {
        try XCTassertEqualsToAny(sut.id, dictionary["id"])
    }

}
