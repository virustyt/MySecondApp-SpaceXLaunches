//
//  LaunchViewModelTests.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 02.11.2021.
//

import XCTest
@testable import SpaceX

class LaunchViewModelTests: XCTestCase {

    var sut: LaunchViewModel!
    
    override func setUp() {
        super.setUp()
        whenSutSetFromLaunch()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSutSetFromLaunch(links: Links = Links(patch: Patch(small: "http//example.com/small",
                                                                large: "http//example.com/large"),
                                                   reddit: Reddit(campaign: "http//example.com/campaign",
                                                                  launch: "http//example.com/launch",
                                                                  media: "http//example.com/media",
                                                                  recovery: "http//example.com/recovery"),
                                                   flickr: Flickr(small: ["http//example.com/small1"],
                                                                  original: ["http//example.com/original"]),
                                                   presskit: "http//example.com/presskit",
                                                   webcast: "http//example.com/webcast",
                                                   youtubeID: "youtubeID",
                                                   article: "http//example.com/article",
                                                   wikipedia: "http//example.com/wikipedia"),
                              staticFireDateUTC: String =  "2020-03-01T10:20:00.000Z",
                              rocket: String = "rocket",
                              success: Bool = true,
                              details: String = "details",
                              name: String = "name",
                              dateUTC: String =  "2020-03-01T10:20:00.000Z",
                              id: String = "id"){
        let launch = Launch(links: links, staticFireDateUTC: staticFireDateUTC, rocket: rocket, success: success, details: details, name: name, dateUTC: dateUTC, id: id, flightNumber: 5)
        sut = LaunchViewModel(launch)
    }
    
    //MARK: - Test initials
    func test_initLaunch_setLinks(){
        XCTAssertEqual(sut.links.patch.small, URL(string:"http//example.com/small")!)
        XCTAssertEqual(sut.links.patch.large, URL(string:"http//example.com/large")!)
        
        XCTAssertEqual(sut.links.reddit.campaign, URL(string:"http//example.com/campaign")!)
        XCTAssertEqual(sut.links.reddit.launch, URL(string:"http//example.com/launch")!)
        XCTAssertEqual(sut.links.reddit.media, URL(string:"http//example.com/media")!)
        XCTAssertEqual(sut.links.reddit.recovery, URL(string:"http//example.com/recovery")!)
        
        XCTAssertEqual(sut.links.flickr.original, [URL(string:"http//example.com/original")!])
        XCTAssertEqual(sut.links.flickr.small, [URL(string:"http//example.com/small1")!])
        
        XCTAssertEqual(sut.links.presskit, URL(string:"http//example.com/presskit")!)
        XCTAssertEqual(sut.links.webcast, URL(string:"http//example.com/webcast")!)
        XCTAssertEqual(sut.links.youtube?.absoluteString, "https://www.youtube.com/watch?v=youtubeID")
        XCTAssertEqual(sut.links.article, URL(string:"http//example.com/article")!)
        XCTAssertEqual(sut.links.wikipedia, URL(string:"http//example.com/wikipedia")!)
    }

    func test_initLaunch_setStaticFireDateUTC(){
        XCTAssertEqual(sut.staticFireDateUTC, "March 1, 2020")
    }
    
    func test_initLaunch_setRocket(){
        XCTAssertEqual(sut.rocket, "rocket")
    }
    
    func test_initLaunch_setSuccess(){
        XCTAssertEqual(sut.success, "Yes")
    }
    
    func test_initLaunch_setDetail(){
        XCTAssertEqual(sut.details, "details")
    }
    
    func test_initLaunch_setName(){
        XCTAssertEqual(sut.name, "name")
    }
    
    func test_initLaunch_setDateUTC(){
        XCTAssertEqual(sut.dateUTC, "March 1, 2020")
    }
    
    func test_initLaunch_setId(){
        XCTAssertEqual(sut.id, "id")
    }
}
