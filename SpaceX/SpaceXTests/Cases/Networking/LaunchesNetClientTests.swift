//
//  LaunchesNetClient.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 21.10.2021.
//

import XCTest
@testable import SpaceX

class LaunchesNetClientTests: XCTestCase {
   
    var sut: LaunchesNetClient!
    var baseUrls: [LaunchesNetClient.SpaceXObject : URL]!
    var mockUrlSession: URLSession!
    var allRocketsUrl: URL {
        return URL(string: "rockets", relativeTo: baseUrls[.rockets])!
    }
    
    override func setUp() {
        super.setUp()
        let baseRocketsUrl = URL(string: "https://api.example.com/1/")!
        let baseLaunchesUrl = URL(string: "https://api.example.com/2/")!
        let baseLaunchpadsUrl = URL(string: "https://api.example.com/3/")!
        baseUrls = [.rockets: baseRocketsUrl,
                    .launches: baseLaunchesUrl,
                    .launchpads: baseLaunchpadsUrl]
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        mockUrlSession = URLSession(configuration: configuration)
        sut = LaunchesNetClient(baseUrls: baseUrls,urlSession: mockUrlSession,responseQueue: nil)
    }
    
    override func tearDown() {
        sut = nil
        baseUrls = nil
        mockUrlSession = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
    func givenMockUrlResponse(data: Data? = nil,
                           statusCode: Int = 200,
                           error: Error? = nil) {
        let response = HTTPURLResponse(url: allRocketsUrl,
                                       statusCode: statusCode,
                                       httpVersion: nil,
                                       headerFields: nil)
        MockURLProtocol.requestHandler = {_ in
            return (data, response, error)
        }
    }
    
    func verifyGetAllRocketsDispatchedToMain(data: Data? = nil, statusCode: Int = 200, error: Error? = nil){
        //given
        sut = LaunchesNetClient(baseUrls: baseUrls,
                                urlSession: mockUrlSession,
                                responseQueue: .main)
        givenMockUrlResponse(data: data, statusCode: statusCode, error: error)
        MockURLProtocol.givenDispatchQueue() //create new queue for executing requestHandler on it
        let expectation = self.expectation(description: "getAllRockets calls complition")
        var complitionThread: Thread!
        //when
        sut.getAllRockets(complition: { rockets, error in
            complitionThread = Thread.current
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(complitionThread.isMainThread)
    }
    
    func test_init_setBaseUrls(){
        XCTAssertEqual(baseUrls, sut.baseUrls)
    }
    
    func test_init_setUrlSession(){
        XCTAssertEqual(mockUrlSession, sut.urlSession)
    }
    
    func test_init_setResponseQueue(){
        let queue = DispatchQueue.main
        sut = LaunchesNetClient.init(baseUrls: baseUrls,
                                     urlSession: mockUrlSession,
                                     responseQueue: queue)
        XCTAssertEqual(queue, sut.resopnseQueue)
    }
    
    func test_shared_setBaseUrls(){
        //given
        let baseUrls: [LaunchesNetClient.SpaceXObject : URL] = [.rockets:URL(string: "https://api.spacexdata.com/v4/")!,
                                                                .launches: URL(string: "https://api.spacexdata.com/v5/")!,
                                                                .launchpads: URL(string: "https://api.spacexdata.com/v4/")!]
        //then
        XCTAssertEqual(baseUrls, LaunchesNetClient.shared.baseUrls)
    }
    
    func test_shared_setUrlSession(){
        //given
        let session = URLSession.shared
        //then
        XCTAssertEqual(session, LaunchesNetClient.shared.urlSession)
    }
    
    func test_shared_setResponseQueue(){
        //given
        let responseQueue = DispatchQueue.main
        //then
        XCTAssertEqual(responseQueue, LaunchesNetClient.shared.resopnseQueue)
    }
    
    func test_getAllRockets_callsExpectedUrl(){
        //given
        let expectation = self.expectation(description: "MockUrlProtocols complition handler was called befor test ends")
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url, self.allRocketsUrl.absoluteURL)
            expectation.fulfill()
            return (nil, nil, nil)
        }
        //when
        sut.getAllRockets(){_, _ in }
        wait(for: [expectation], timeout: 10)
    }

    func test_getAllRockets_callsResumeOnTask(){
        //given
        let expectation = self.expectation(description: "Resume was called on dataTask")
        MockURLProtocol.requestHandler = {_ in
            expectation.fulfill()
            return (nil, nil, nil)
        }
        //when
        sut.getAllRockets(complition: {_, _ in})
        //then
        wait(for: [expectation], timeout: 10)
    }
    
    func test_getAllRockets_givenResponseStatusCode500_callsComplition(){
        //given
        givenMockUrlResponse(statusCode: 500)
        let expectation = self.expectation(description: "getAllRockets called complition handler.")
        //when
        sut.getAllRockets(complition: {rockets, error in
            XCTAssertNil(rockets)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        //then
        wait(for: [expectation], timeout: 10)
    }
    
    func test_getAllRockets_givenError_callsComplitionWithError(){
        //given
        let error: NSError? = NSError(domain: "com.SpaceXTests", code: 42)
        givenMockUrlResponse(error: error)
        let expectetion = self.expectation(description: "getAllRockets called complition handler")
        //when
        sut.getAllRockets(complition: {rockets, recievedError in
            XCTAssertNil(rockets)
            XCTAssertEqual(error?.domain, (recievedError as NSError?)?.domain)
            XCTAssertEqual(error?.code, (recievedError as NSError?)?.code)
            expectetion.fulfill()
        })
        //then
        wait(for: [expectetion], timeout: 10)
    }
    
    func test_getAllRockets_givenValidJSON_callsComplitionWithRockets() throws {
        //given
        let data = try Data.fromJson(fileName: "GET_Rockets_Response")
        let givenRockets = try JSONDecoder().decode([Rocket].self, from: data)
        let expectation = self.expectation(description: "getAllRockets recieved non nil data and called complition handler")
        givenMockUrlResponse(data: data)
        //when
        sut.getAllRockets(complition: {rockets, error in
            XCTAssertEqual(rockets, givenRockets)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        //then
        wait(for: [expectation], timeout: 10)
    }
    
    func test_getAllRockets_givenInvalidJSON_callsComplitionWithError() throws {
        //given
        let expectation = self.expectation(description: "getAllRockets calls complition with error")
        let data = try Data.fromJson(fileName: "GET_Rockets_MissingValuesResponse")
        var expectedError: NSError?
        do {
            _ = try JSONDecoder().decode([Rocket].self, from: data)
        }
        catch{
            expectedError = error as NSError?
        }
        givenMockUrlResponse(data: data)
        //when
        sut.getAllRockets(complition: {rockets, error in
            XCTAssertNil(rockets)
            let recievedError = error as NSError?
            XCTAssertNotNil(recievedError)
            XCTAssertEqual(expectedError?.domain, recievedError?.domain)
            XCTAssertEqual(expectedError?.code, recievedError?.code)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10)
    }
    
    func test_getAllRockets_givenHTTPStatusError_dispatchToResponseQueue(){
        verifyGetAllRocketsDispatchedToMain(statusCode: 500)
    }
    
    func test_getAllRockets_givenError_dispatchToResponseQueue(){
        //given
        let error: NSError? = NSError(domain: "com.SpaceXTests", code: 42)
        //then
        verifyGetAllRocketsDispatchedToMain(error: error)
    }
    
    func test_gettAllRockets_givenValidJSON_dispatchToResponseQueue() throws {
        //given
        let data = try Data.fromJson(fileName: "GET_Rockets_Response")
        //then
        verifyGetAllRocketsDispatchedToMain(data: data)
    }
    
    func test_gettAllRockets_givenInvalidJSON_dispatchToResponseQueue()throws  {
        //given
        let data = try Data.fromJson(fileName: "GET_Rockets_MissingValuesResponse")
        //then
        verifyGetAllRocketsDispatchedToMain(data: data)
    }
}


//MARK: - mockURLProtocol
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) -> (Data?, HTTPURLResponse?, Error?))?
    static var responseQueue: DispatchQueue?
    
    override class func canInit(with request: URLRequest) -> Bool { true }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("MockUrlSession.RequestHandler is nil.")
            return
        }
        if let queue = MockURLProtocol.responseQueue {
            queue.async {
                let (data, response, error) = handler(self.request)
                self.produceResponse(data: data, response: response, error: error)
            }
        }
        else {
            let (data, response, error) = handler(request)
            self.produceResponse(data: data, response: response, error: error)
        }
    }
    
    override func stopLoading() {}
    
    private func produceResponse(data: Data?, response: HTTPURLResponse?, error: Error?){
        if let recievedData = data {
            client?.urlProtocol(self, didLoad: recievedData)
        }
        if let recievedResponse = response {
            client?.urlProtocol(self, didReceive: recievedResponse, cacheStoragePolicy: .notAllowed)
        }
        if let recievedError = error {
            client?.urlProtocol(self, didFailWithError: recievedError)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    static func givenDispatchQueue(){
        MockURLProtocol.responseQueue = DispatchQueue(label: "com.SpaceXTests.MockUrlProtocol")
    }
}



