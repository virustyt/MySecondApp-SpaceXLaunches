//
//  LaunchpadTests.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 02.11.2021.
//

import XCTest
@testable import SpaceX

class LaunchpadTests: XCTestCase, DecodableTestCase {
    var dictionary: NSDictionary!
    
    var sut: Launchpad!
    
    override func setUp() {
        try! givenSutFromJSON()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    //MARK: - Test types
    func test_Launchpad_isDecodable(){
        XCTAssert( (sut as Any) is Decodable)
    }
    
    func test_Launchpad_isEquotable(){
        XCTAssertEqual(sut, sut)
    }
    
//    let name: String
//    let fullName: String
//    let locality: String
//    let region: String
//    let timeZoneIdentifyer: String
//    let latitude: Double
//    let longitude: Double
//    let launchAttempts: Int
//    let launchSuccesses: Int
//    let rocketImages: [String]
//    let launcheImages: [String]
//    let status: String
//    let id: String
    
    //MARK: - Init tests
    func test_initLaunchpad_setName() throws {
        try XCTassertEqualsToAny(sut.name, dictionary["name"])
    }
    
    func test_initLaunchpad_setFullName() throws{
        try XCTassertEqualsToAny(sut.fullName, dictionary["full_name"])
    }
    
    func test_initLaunchpad_setLocality() throws{
        try XCTassertEqualsToAny(sut.locality, dictionary["locality"])
    }
    
    func test_initLaunchpad_setRegion() throws{
        try XCTassertEqualsToAny(sut.region, dictionary["region"])
    }
    
    func test_initLaunchpad_setTimeZoneIdentifyer() throws{
        try XCTassertEqualsToAny(sut.timeZoneIdentifyer, dictionary["timezone"])
    }
    
    func test_initLaunchpad_setLatitude() throws{
        try XCTassertEqualsToAny(sut.latitude, dictionary["latitude"])
    }
    
    func test_initLaunchpad_setLongitude() throws{
        try XCTassertEqualsToAny(sut.longitude, dictionary["longitude"])
    }
    
    func test_initLaunchpad_setLaunchAttempts() throws{
        try XCTassertEqualsToAny(sut.launchAttempts, dictionary["launch_attempts"])
    }
    
    func test_initLaunchpad_setLaunchSuccesses() throws{
        try XCTassertEqualsToAny(sut.launchSuccesses, dictionary["launch_successes"])
    }
    
    func test_initLaunchpad_setRocketImages() throws{
        try XCTassertEqualsToAny(sut.rocketImages, dictionary["rockets"])
    }
    
    func test_initLaunchpad_setLauncheImages() throws{
        try XCTassertEqualsToAny(sut.launcheImages, dictionary["launches"])
    }
    
    func test_initLaunchpad_setStatus() throws{
        try XCTassertEqualsToAny(sut.status, dictionary["status"])
    }
    
    func test_initLaunchpad_setId() throws{
        try XCTassertEqualsToAny(sut.id, dictionary["id"])
    }
}
