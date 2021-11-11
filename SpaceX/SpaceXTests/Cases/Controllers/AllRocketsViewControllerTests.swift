//
//  AllRocketsViewControllerTests.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 03.11.2021.
//

import XCTest
@testable import SpaceX

class AllRocketsViewControllerTests: XCTestCase {

    var sut: AllRocketsViewController!
    var mockNetworkClient: MockLaunchesNetClient!
    var mockTableView: MockTableView!
    
    override func setUp() {
        super.setUp()
        sut = AllRocketsViewController()
        sut.viewDidLoad()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func givenMockNetworkClient(){
        mockNetworkClient = MockLaunchesNetClient()
        sut.networkClient = mockNetworkClient
    }
    
    func givenSomeRockets(count: Int = 3) -> [Rocket]{
        var rockets = [Rocket]()
        for i in 1...count {
            let rocket = Rocket(height: MetersAndFeets(meters: Double(i * 8), feet: Double(i * 18)),
                                diameter: MetersAndFeets(meters: Double(i * 67), feet: Double(i * 134)),
                                mass: Mass(kg: i * 300, lb: i * 430),
                                firstStage: FirstStage(thrustSeaLevel: Thrust(kN: i * 56, lbf: i * 12),
                                                       thrustVacuum: Thrust(kN: i * 39, lbf: i * 86),
                                                       reusable: true,
                                                       engines: i * 4,
                                                       fuelAmountTons: i * 690,
                                                       burnTimeSEC: i * 596),
                                secondStage: SecondStage(thrust: Thrust(kN: i * 90, lbf: i * 54),
                                                         payloads: Payloads(compositeFairing: CompositeFairing(height: MetersAndFeets(meters: Double(i) * 58.7, feet: Double(i) * 858.7),
                                                                                                               diameter: MetersAndFeets(meters: Double(i * 854), feet: Double(i) * 937.7)),
                                                                            option1: "option_goood"),
                                                         reusable: true,
                                                         engines: i * 6,
                                                         fuelAmountTons: i * 695,
                                                         burnTimeSEC: i * 5739),
                                engines: Engines (isp: ISP(seaLevel: i * 1, vacuum: i * 2),
                                                  thrustSeaLevel: Thrust(kN: i * 3, lbf: i * 4),
                                                  thrustVacuum: Thrust(kN: i * 5, lbf: i * 6),
                                                  number: i * 7,
                                                  type: "type \(i * 5)",
                                                  version: "version \(i)",
                                                  layout: "layput \(i)",
                                                  engineLossMax: i * 11,
                                                  propellant1: "propellant1 \(i)",
                                                  propellant2: "propellant2 \(i)",
                                                  thrustToWeight: Double(i * 14)),
                                landingLegs: LandingLegs (number: i * 1, material: "material \(i)"),
                                payloadWeights:[PayloadWeight(id: "id \(i)", name: "name \(i)", kg: i * 3, lb: i * 4)],
                                flickrImages:  ["http//example.com/\(i)"],
                                name:"name \(i)",
                                type: "type \(i)",
                                active: true,
                                stages: 1,
                                boosters: 2,
                                costPerLaunch: 3,
                                successRatePct: 4,
                                firstFlight: "2018-02-\(i)",
                                country: "country \(i)",
                                company: "company \(i)",
                                wikipedia: "http//wikipedia.org/\(i)",
                                welcomeDescription: "welcome  \(i)",
                                id: " \(i)")
            rockets.append(rocket)
        }
        return rockets
    }
    
    func givenMockTableView(){
        mockTableView = MockTableView()
        sut.tableView = mockTableView
    }
    
    //MARK: - Instance property tests
    func test_AllRocketsViewController_setNetworkClient(){
        XCTAssert((sut.networkClient as? LaunchesNetClient) === LaunchesNetClient.shared)
    }
    
    //MARK: - Refresh data tests
    func test_ifAlreadyRefreshing_doesNotCallAgain(){
        //given
        givenMockNetworkClient()
        //when
        sut.refreshData()
        sut.refreshData()
        //then
        XCTAssertEqual(mockNetworkClient.getAllRocketsCalls, 1)
    }
    
    func test_refreshData_ComplitionNilsDataTask(){
        //given
        givenMockNetworkClient()
        //when
        sut.refreshData()
        mockNetworkClient.complition(nil, nil)
        //then
        XCTAssertNil(sut.dataTask)
    }
    
    func test_refreshData_givenRocketsRedponse_setsViewModels(){
        //given
        let rockets: [Rocket] = givenSomeRockets()
        let rocketViewModels: [RocketViewModel] = rockets.map { RocketViewModel(rocket: $0)}
        givenMockNetworkClient()
        //when
        sut.refreshData()
        mockNetworkClient.complition(rockets,nil)
        //then
        XCTAssertEqual(sut.viewModels, rocketViewModels)
    }
    
    func test_refreshData_givenRocketsResponse_reloadsTableView(){
        //given
        let rockets: [Rocket] = givenSomeRockets()
        givenMockNetworkClient()
        givenMockTableView()
        //when
        sut.refreshData()
        mockNetworkClient.complition(rockets,nil)
        //then
        XCTAssert(mockTableView.reloadDataCalled)
    }
    
    func test_refreshControl_beginsRefreshing(){
        //given
        givenMockNetworkClient()
        //when
        sut.refreshData()
        //then
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.tableView!.refreshControl)
        XCTAssert(sut.tableView!.refreshControl!.isRefreshing)
    }
    
    func test_refreshData_givenRocketsResponse_endsRefreshing(){
        //given
        let rockets: [Rocket] = givenSomeRockets()
        givenMockNetworkClient()
        //when
        sut.refreshData()
        mockNetworkClient.complition(rockets, nil)
        //then
        XCTAssertFalse(sut.tableView!.refreshControl!.isRefreshing)
    }
    
    
}


