//
//  LaunchpadViewModelTests.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 02.11.2021.
//

import XCTest
@testable import SpaceX

class LaunchpadViewModelTests: XCTestCase {

    var sut: LaunchpadViewModel!
    
    override func setUp() {
        super.setUp()
        whenSutSetFromLaunchpad()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSutSetFromLaunchpad(name: String = "name",
                                 fullName: String = "fullName",
                                 locality: String = "locality",
                                 region: String = "region",
                                 timeZoneIdentifyer: String = "timeZoneIdentifyer",
                                 latitude: Double = 78.8,
                                 longitude: Double = 65.7,
                                 launchAttempts: Int =  23,
                                 launchSuccesses: Int =  32,
                                 rocketImages: [String] = ["rocketOne"],
                                 launcheImages: [String] = ["launche"],
                                 status: String = "status",
                                 id: String = "id"){
        let launchpad = Launchpad(name: name, fullName: fullName, locality: locality, region: region, timeZoneIdentifyer: timeZoneIdentifyer, latitude: latitude, longitude: longitude, launchAttempts: launchAttempts, launchSuccesses: launchSuccesses, rocketImages: rocketImages, launcheImages: launcheImages, status: status, id: id)
        sut = LaunchpadViewModel(launchpad)
    }
    
    //MARK: - Test inits
    func test_initLaunchpad_setFullName(){
        XCTAssertEqual(sut.fullName, "fullName")
    }
    
    func test_initLaunchpad_setLocality(){
        XCTAssertEqual(sut.locality, "locality")
    }
    
    func test_initLaunchpad_setRegion(){
        XCTAssertEqual(sut.region, "region")
    }
    
    func test_initLaunchpad_setLatitude(){
        XCTAssertEqual(sut.latitude, 78.8)
    }
    
    func test_initLaunchpad_setLongitude(){
        XCTAssertEqual(sut.longitude, 65.7)
    }
    
    func test_initLaunchpad_setLaunchAttempts(){
        XCTAssertEqual(sut.launchAttempts, 23)
    }
    
    func test_initLaunchpad_setLaunchSuccesses(){
        XCTAssertEqual(sut.launchSuccesses, 32)
    }
    
    func test_initLaunchpad_setRocketImages(){
        XCTAssertEqual(sut.rocketImages, ["rocketOne"])
    }
    
    func test_initLaunchpad_setLauncheImages(){
        XCTAssertEqual(sut.launcheImages, ["launche"])
    }
    
    func test_initLaunchpad_setStatus(){
        XCTAssertEqual(sut.status, "status")
    }
    
    func test_initLaunchpad_setid(){
        XCTAssertEqual(sut.id, "id")
    }

}
