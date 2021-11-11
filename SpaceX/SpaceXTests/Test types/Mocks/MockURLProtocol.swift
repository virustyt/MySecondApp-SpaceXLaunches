//
//  MockURLProtocol.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 04.11.2021.
//

import Foundation
import XCTest

//MARK: - mockURLProtocol
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) -> (Data?, HTTPURLResponse?, Error?))?
    static var responseQueue: DispatchQueue?
    static var responseCancelled = false
    
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
    
    override func stopLoading() {    }
    
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
