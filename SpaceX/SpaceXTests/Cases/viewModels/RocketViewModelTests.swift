//
//  RocketViewModelTests.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 01.11.2021.
//

import XCTest
@testable import SpaceX

class RocketViewModelTests: XCTestCase {

    var sut: RocketViewModel!
    var rocket: Rocket!
    
    override func setUp() {
        super.setUp()
        whenSutSetFromRocket()
    }
    
    override func tearDown() {
        sut = nil
        rocket = nil
        super.tearDown()
    }
    
    func whenSutSetFromRocket(height: MetersAndFeets = MetersAndFeets(meters: 8, feet: 16),
                              diameter: MetersAndFeets = MetersAndFeets(meters: 67, feet: 134),
                              mass: Mass = Mass(kg: 300, lb: 430),
                              firstStage: FirstStage = FirstStage(thrustSeaLevel: Thrust(kN: 56, lbf: 12),
                                                                 thrustVacuum: Thrust(kN: 39, lbf: 86),
                                                                 reusable: true,
                                                                 engines: 4,
                                                                 fuelAmountTons: 690,
                                                                 burnTimeSEC: 596),
                              secondStage: SecondStage = SecondStage(thrust: Thrust(kN: 90, lbf: 54),
                                                                     payloads: Payloads(compositeFairing: CompositeFairing(height: MetersAndFeets(meters: 58.7, feet: 858.7),
                                                                                                                           diameter: MetersAndFeets(meters: 854, feet: 937.7)),
                                                                                        option1: "option_goood"),
                                                                     reusable: true,
                                                                     engines: 6,
                                                                     fuelAmountTons: 695,
                                                                     burnTimeSEC: 5739),
                              engines: Engines = Engines(isp: ISP(seaLevel: 1, vacuum: 2),
                                                         thrustSeaLevel: Thrust(kN: 3, lbf: 4),
                                                         thrustVacuum: Thrust(kN: 5, lbf: 6),
                                                         number: 7,
                                                         type: "8",
                                                         version: "9",
                                                         layout: "10",
                                                         engineLossMax: 11,
                                                         propellant1: "12",
                                                         propellant2: "13",
                                                         thrustToWeight: 14),
                              landingLegs: LandingLegs = LandingLegs(number: 1, material: "2"),
                              payloadWeights: [PayloadWeight] = [PayloadWeight(id: "id", name: "name", kg: 3, lb: 4)],
                              flickrImages: [String] = ["http//example.com/1"],
                              name:String = "name",
                              type: String = "type",
                              active: Bool = true,
                              stages: Int = 1,
                              boosters: Int = 2,
                              costPerLaunch: Int = 3,
                              successRatePct: Int = 4,
                              firstFlight: String = "2018-02-06",
                              country: String = "country",
                              company: String = "company",
                              wikipedia: String = "http//wikipedia.org",
                              welcomeDescription: String = "welcome",
                              id: String = "qwerty"){
        
        rocket = Rocket(height: height,
                        diameter: diameter,
                        mass: mass,
                        firstStage: firstStage,
                        secondStage: secondStage,
                        engines: engines,
                        landingLegs: landingLegs,
                        payloadWeights: payloadWeights,
                        flickrImages: flickrImages,
                        name: name,
                        type: type,
                        active: active,
                        stages: stages,
                        boosters: boosters,
                        costPerLaunch: costPerLaunch,
                        successRatePct: successRatePct,
                        firstFlight: firstFlight,
                        country: country,
                        company: company,
                        wikipedia: wikipedia,
                        welcomeDescription: welcomeDescription,
                        id: id)
        sut = RocketViewModel(rocket: rocket)
    }

    //MARK: = Initial tests
    func test_initRocket_setRocket(){
        XCTAssertEqual(sut.rocket, rocket)
    }
    
    func test_initRocket_setHeight(){
        //when
        whenSutSetFromRocket(height: MetersAndFeets(meters: 12, feet: 16))
        //then
        XCTAssertEqual(sut.height, "12 meters")
    }
    
    func test_initRocket_setDiameter(){
        //when
        whenSutSetFromRocket(diameter: MetersAndFeets(meters: 21, feet: 22))
        //then
        XCTAssertEqual(sut.diameter, "21 meters")
    }
    
    func test_initRocket_setMass(){
        //when
        whenSutSetFromRocket(mass: Mass(kg: 233, lb: 933))
        //then
        XCTAssertEqual(sut.mass, "233 kg")
    }

    func test_initRocket_setFirstStage(){
        //given
        let firstStage = FirstStage(thrustSeaLevel: Thrust(kN: 56, lbf: 78),
                                    thrustVacuum: Thrust(kN: 21, lbf: 32),
                                    reusable: true,
                                    engines: 8,
                                    fuelAmountTons: 67,
                                    burnTimeSEC: 576)
        //when
        whenSutSetFromRocket(firstStage: firstStage)
        //then
        XCTAssertEqual(sut.firstStage.thrustSeaLevel, "56 kN")
        XCTAssertEqual(sut.firstStage.thrustVacuum, "21 kN")
        XCTAssertEqual(sut.firstStage.reusable, "Yes")
        XCTAssertEqual(sut.firstStage.engines, "8")
        XCTAssertEqual(sut.firstStage.fuelAmountTons, "67 tons")
        XCTAssertEqual(sut.firstStage.burnTimeSEC, "576 seconds")
    }
    
    func test_initRocket_setSecondStage(){
        //given
        let secondStage = SecondStage(thrust: Thrust(kN: 85, lbf: 43),
                                      payloads: Payloads(compositeFairing: CompositeFairing(height: MetersAndFeets(meters: 32, feet: 34),
                                                                                            diameter: MetersAndFeets(meters: 56, feet: 21)),
                                                         option1: "opt"),
                                      reusable: false,
                                      engines: 7,
                                      fuelAmountTons: 234,
                                      burnTimeSEC: 239)
        //when
        whenSutSetFromRocket(secondStage: secondStage)
        //then
        XCTAssertEqual(sut.secondStage.thrust, "85 kN")
        XCTAssertEqual(sut.secondStage.reusable, "No")
        XCTAssertEqual(sut.secondStage.engines, "7")
        XCTAssertEqual(sut.secondStage.fuelAmountTons, "234 tons")
        XCTAssertEqual(sut.secondStage.burnTimeSEC, "239 seconds")
    }

    func test_initRocket_setEngines(){
        //given
        let engines = Engines(isp: ISP(seaLevel: 45, vacuum: 32),
                              thrustSeaLevel: Thrust(kN: 90, lbf: 32),
                              thrustVacuum: Thrust(kN: 12, lbf: 67),
                              number: 4,
                              type: "testType",
                              version: "testVersion",
                              layout: "testLayout",
                              engineLossMax: 9,
                              propellant1: "one",
                              propellant2: "two",
                              thrustToWeight: 34.8)
        //when
        whenSutSetFromRocket(engines:engines)
        //then
        XCTAssertEqual(sut.engines.number, "4")
        XCTAssertEqual(sut.engines.type, "testType")
        XCTAssertEqual(sut.engines.version, "testVersion")
        XCTAssertEqual(sut.engines.layout, "testLayout")
        XCTAssertEqual(sut.engines.propellant1, "one")
        XCTAssertEqual(sut.engines.propellant2, "two")
    }
    
    func test_initRocket_setLandingLegs(){
        //when
        whenSutSetFromRocket(landingLegs: LandingLegs(number: 4, material: "stone"))
        //then
        XCTAssertEqual(sut.landingLegs.number, "4")
        XCTAssertEqual(sut.landingLegs.material, "stone")
    }
    
    func test_initRocket_setFlickrImages(){
        //given
        let url = URL(string: "http//example.com/image1")!
        //when
        whenSutSetFromRocket(flickrImages: [url.absoluteString])
        //then
        XCTAssertEqual(sut.flickrImages.first, url)
    }
    
    func test_initRocket_setName(){
        //when
        whenSutSetFromRocket(name: "Bob")
        //then
        XCTAssertEqual(sut.name, "Bob")
    }
    
    func test_initRocket_setCostPerLaunch(){
        //when
        whenSutSetFromRocket(costPerLaunch: 87645)
        //then
        XCTAssertEqual(sut.costPerLaunch, "87645$")
    }
    
    func test_initRocket_setSuccessRatePct(){
        //when
        whenSutSetFromRocket(successRatePct:56)
        //then
        XCTAssertEqual(sut.successRatePct, "56%")
    }
    
    func test_initRocket_setFirstFlight(){
        //when
        whenSutSetFromRocket(firstFlight: "2018-02-06")
        //then
        XCTAssertEqual(sut.firstFlight, "February 6, 2018")
    }
    
    func test_initRocket_setWikipedia(){
        //given
        let url = URL(string: "http//example.com/info")!
        //when
        whenSutSetFromRocket(wikipedia: url.absoluteString)
        //then
        XCTAssertEqual(sut.wikipedia, url)
    }
    
    func test_initRocket_setWelcomeDescripton(){
        //when
        whenSutSetFromRocket(welcomeDescription: "Hi Bob")
        //then
        XCTAssertEqual(sut.welcomeDescription, "Hi Bob")
    }
    
    func test_initRocket_setId(){
        //when
        whenSutSetFromRocket(id: "id")
        //then
        XCTAssertEqual(sut.id, "id")
    }
}
