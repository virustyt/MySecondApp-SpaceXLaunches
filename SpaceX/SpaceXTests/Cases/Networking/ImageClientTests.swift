//
//  ImageClientTests.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 04.11.2021.
//

import XCTest
@testable import SpaceX

class ImageClientTests: XCTestCase {
    
    var sut: ImageClient!
    var mockURLSession: URLSession!
    var sutAsProtocol: ImageClientProtocol {
        return sut as ImageClientProtocol
    }
    var dummyURL: URL!
    var recievedDataTask: URLSessionDataTask!
    var recievedImage: UIImage!
    var recievedError: Error!
    var recievedTread: Thread!
    var expectedImage:UIImage!
    var expectedError: NSError!
    var givenImageView: UIImageView!

    override func setUp() {
        super.setUp()
        givenImageView = UIImageView()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        mockURLSession = URLSession(configuration: configuration)
        sut = ImageClient(urlSession: mockURLSession, responseQueue: nil)
        dummyURL = URL(string: "dymmy")
    }
    
    override func tearDown() {
        sut = nil
        dummyURL = nil
        MockURLProtocol.requestHandler = nil
        MockURLProtocol.responseCancelled = false
        recievedDataTask = nil
        recievedImage = nil
        recievedError = nil
        recievedTread = nil
        expectedImage = nil
        expectedError = nil
        givenImageView = nil
        super.tearDown()
    }
    
    func whenDownloadImage(image: UIImage? = nil, error: Error? = nil){
        if let image = image{
            MockURLProtocol.requestHandler = { request in
                return (image.pngData(), nil, nil)
            }
        }
        if let error = error {
            MockURLProtocol.requestHandler = { request in
                return (nil, nil, error)
            }
        }
        
        let expect = expectation(description: "downloadImages complition completed")
        recievedDataTask = sut.downloadImages(imageURL: dummyURL, complition: { [self]responseImage, responseError in
            if let notNilImage = responseImage { self.recievedImage = notNilImage }
            if let notNilError = responseError { self.recievedError = notNilError }
            self.recievedTread = Thread.current
            expect.fulfill()
        })
        wait(for: [expect], timeout: 4)
    }
    
    func whenSetImageWithGivenResponse(statusCode: Int = 200, error: Error? = nil){
        //given
        let expectation = expectation(description: "dataTask complition ended")
        givenExpectedImage()
        let givenData: Data? = expectedImage.pngData()
        givenMockUrlResponse(data: givenData, statusCode: statusCode, error: error)
        //when
        sut.setImage(on: givenImageView, from: dummyURL, with: expectedImage, complition: {image, error in expectation.fulfill()})
        wait(for: [expectation], timeout: 5)
    }
    
    func verifyDowloadImageDispatchThread(image:UIImage? = nil, error: Error? = nil){
        //given
        MockURLProtocol.givenDispatchQueue()
        sut = ImageClient(urlSession: mockURLSession, responseQueue: .main)
        //when
        whenDownloadImage(image: image, error: error)
        //then
        XCTAssert(recievedTread.isMainThread)
    }
    
    func givenExpectedImage(){
        expectedImage = UIImage(named: "Mountains")!
    }
    
    func givenExpectedError(){
        expectedError = NSError(domain: "com.SpaceX", code: 42)
    }
    
    func givenMockUrlResponse(data: Data? = nil,
                           statusCode: Int = 200,
                           error: Error? = nil) {
        let response = HTTPURLResponse(url: dummyURL,
                                       statusCode: statusCode,
                                       httpVersion: nil,
                                       headerFields: nil)
        MockURLProtocol.requestHandler = {_ in
            return (data, response, error)
        }
    }
    
    
    //MARK: - Init tests
    func test_init_setsUrlSession(){
        XCTAssertEqual(sut.urlSession, mockURLSession)
    }
    
    func test_init_setsresponseQueue(){
        XCTAssertEqual(sut.responseQueue, nil)
    }
    
    func test_init_setsCashedImages(){
        XCTAssertEqual(sut.cashedImages, [:])
    }
    
    func test_init_setsCashedDataTasks(){
        XCTAssertEqual(sut.cashedDataTasks, [:])
    }
    
    //MARK: - Static Properties - Tests
    func test_shared_setsResponseQueue() {
    XCTAssertEqual(ImageClient.shared.responseQueue, .main)
    }
    
    func test_shared_setsSession() {
    XCTAssertEqual(ImageClient.shared.urlSession, .shared)
    }
    
    //MARK: - ImageClientProtocol tests
    func test_ImageClient_conformsToImageClientProtocol(){
        XCTAssert((sut as Any) is ImageClientProtocol)
    }
    
    func test_ImageClientProtocol_declaresDownloadImage(){
        //then
        _ = sutAsProtocol.downloadImages(imageURL: URL(string: "dummy")!, complition: {_, _ in })
    }
    
    func test_ImageClientProtocol_declaresSetImageForImageView(){
        //then
        _ = sutAsProtocol.setImage(on: UIImageView(), from: URL(string: "dummy")!, with: nil, complition: nil)
    }
    
    //MARK: - downloadImage Tests
    func test_downloadImage_createsExpectedDataTaskAnsCallsResumeOnIt(){
        //given
        let expectation = expectation(description: "downloadImage complition was callled")
        MockURLProtocol.requestHandler = {request in
            XCTAssertEqual(request.url, self.dummyURL)
            expectation.fulfill()
            return (nil, nil,nil)
        }
        //when
        _ = sut.downloadImages(imageURL: dummyURL, complition: {_,_ in })
        //then
        wait(for: [expectation], timeout: 4)
    }
    
    func test_downloadImage_givenImage_callsComplitionWithImage(){
        //given
        givenExpectedImage()
        //when
        whenDownloadImage(image: expectedImage)
        //then
        XCTAssertEqual(recievedImage.pngData(), expectedImage.pngData())
    }
    
    func test_downloadImage_givenError_collsComplition(){
        //given
        givenExpectedError()
        //when
        whenDownloadImage(error: expectedError)
        //then
        XCTAssertEqual((recievedError as NSError).domain, expectedError.domain)
        XCTAssertEqual((recievedError as NSError).code, expectedError.code)
    }
    
    func test_givenImage_dispatchCompltion(){
        //given
        givenExpectedImage()
        //then
        verifyDowloadImageDispatchThread(image: expectedImage)
    }
    
    func test_givenError_dispatchCompltion(){
        //given
        givenExpectedError()
        //then
        verifyDowloadImageDispatchThread(error: expectedError)
    }
    
    func test_downloadImage_givenImage_cashedImage(){
        //given
        givenExpectedImage()
        //when
        whenDownloadImage(image: expectedImage)
        //then
        XCTAssertEqual(sut.cashedImages[dummyURL]?.pngData(), expectedImage.pngData())
    }
    
    func test_downloadImage_givenCashedImage_returnNillDataTask(){
        //given
        givenExpectedImage()
        //when
        whenDownloadImage(image: expectedImage)
        whenDownloadImage(image: expectedImage)
        //then
        XCTAssertNil(recievedDataTask)
    }
    
    func test_downloadImage_givenCashedImage_callsComplitionWithImage(){
        //given
        givenExpectedImage()
        //when
        whenDownloadImage(image: expectedImage)
        recievedImage = nil
        whenDownloadImage(image: expectedImage)
        //then
        XCTAssertEqual(recievedImage.pngData(), expectedImage.pngData())
    }
    
    //MARK: - setImage tests
    func test_setImage_cancelsExistingDataTask(){
        //given
        givenExpectedImage()
        let givenDataTask = mockURLSession.dataTask(with: dummyURL)
        sut.cashedDataTasks[dummyURL] = givenDataTask
        //when
        sut.setImage(on: givenImageView, from: dummyURL, with: nil)
        //then
        XCTAssertEqual(URLSessionTask.State.canceling, givenDataTask.state)
    }
    
    func test_setImage_setPlaceholdeerImageOnImageView(){
        //given
        givenExpectedImage()
        //when
        sut.setImage(on: givenImageView, from: dummyURL, with: expectedImage)
        //then
        XCTAssertEqual(givenImageView.image?.pngData(), expectedImage.pngData())
    }
    
    func test_setImage_cashesDataTask(){
        //given
        sut.cashedDataTasks = [:]
        //when
        sut.setImage(on: givenImageView, from: dummyURL, with: nil, complition: {[weak self] _,_ in
                        guard let self = self else {XCTFail();return}
                        //then
                        XCTAssertNotNil(self.sut.cashedDataTasks[self.dummyURL])})
    }
    
    func test_setImage_onComplitionRemovesCashedDataTask(){
        //when
        whenSetImageWithGivenResponse()
        //then
        XCTAssertNil(sut.cashedDataTasks[dummyURL])
    }
    
    func test_setImage_onComplitionSetsImage(){
        //when
        whenSetImageWithGivenResponse()
        //then
        XCTAssertEqual(givenImageView.image?.pngData(), expectedImage.pngData())
    }
    
    func test_setImageOnImageView_givenError_doesnSetImage() {
        // given
        givenExpectedError()
        //when
        whenSetImageWithGivenResponse(error: expectedError) // here sets expectedImage
        //then
        XCTAssertEqual(givenImageView.image?.pngData(), expectedImage.pngData())
    }
    
    
}
