//
//  Rocket.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 30.10.2021.
//

import XCTest
@testable import SpaceX

class RocketTests: XCTestCase, DecodableTestCase {
    var sut: Rocket!
    var dictionary: NSDictionary!
    

    override func setUp() {
      super.setUp()
      try! givenSutFromJSON()
    }
    
    override func tearDown() {
        sut = nil
        dictionary = nil
        super.tearDown()
    }
    
    //MARK: - Type tests
    func test_conformsTo_Decodable(){
        XCTAssertTrue((sut as Any) is Decodable) // cast silences a warning
    }
    
    func test_conformsTo_Equotable(){
        XCTAssertEqual(sut, sut)
    }
    
    //MARK: - Decodable tests
    func test_decodable_setHeight() throws {
        let givenHeight = try XCTUnwrap(dictionary["height"] as? Dictionary<String,Any?>)
        try XCTassertEqualsToAny(sut.height?.feet, givenHeight["feet"]!)
        try XCTassertEqualsToAny(sut.height?.meters, givenHeight["meters"]!)
    }
    
    func test_decodable_setDiameter() throws {
        let givenDiameter = try XCTUnwrap(dictionary["diameter"] as? Dictionary<String,Any?>)
        try XCTassertEqualsToAny(sut.diameter?.feet, givenDiameter["feet"]!)
        try XCTassertEqualsToAny(sut.diameter?.meters, givenDiameter["meters"]!)
    }
    
    func test_decodable_setMass() throws {
        let givenMass = try XCTUnwrap(dictionary["mass"] as? Dictionary<String,Any?>)
        try XCTassertEqualsToAny(sut.mass?.kg, givenMass["kg"]!)
        try XCTassertEqualsToAny(sut.mass?.lb, givenMass["lb"]!)
    }
    
    func test_decodable_setFirstStage() throws {
        let givenFirstStage = try XCTUnwrap(dictionary["first_stage"] as? Dictionary<String,Any?>)
        let givenThrustSeaLevel = try XCTUnwrap(givenFirstStage["thrust_sea_level"] as? Dictionary<String,Any?>)
        let givenThrustVacuum = try XCTUnwrap(givenFirstStage["thrust_vacuum"] as? Dictionary<String,Any?>)
        
        try XCTassertEqualsToAny(sut.firstStage?.burnTimeSEC, givenFirstStage["burn_time_sec"]!)
        try XCTassertEqualsToAny(sut.firstStage?.engines, givenFirstStage["engines"]!)
        try XCTassertEqualsToAny(sut.firstStage?.fuelAmountTons, givenFirstStage["fuel_amount_tons"]!)
        try XCTassertEqualsToAny(sut.firstStage?.reusable, givenFirstStage["reusable"]!)
            
        try XCTassertEqualsToAny(sut.firstStage?.thrustSeaLevel?.kN, givenThrustSeaLevel["kN"]!)
        try XCTassertEqualsToAny(sut.firstStage?.thrustSeaLevel?.lbf, givenThrustSeaLevel["lbf"]!)
        
        try XCTassertEqualsToAny(sut.firstStage?.thrustVacuum?.kN, givenThrustVacuum["kN"]!)
        try XCTassertEqualsToAny(sut.firstStage?.thrustVacuum?.lbf, givenThrustVacuum["lbf"]!)
    }
    
    func test_decodable_setSecondStage() throws {
        let givenSecondStage = try XCTUnwrap(dictionary["second_stage"] as? Dictionary<String,Any?>)
        let givenThrust = try XCTUnwrap(givenSecondStage["thrust"] as? Dictionary<String,Any?>)
        let givenPayloads = try XCTUnwrap(givenSecondStage["payloads"] as? Dictionary<String,Any?>)
        let givenCompositeFairing = try XCTUnwrap(givenPayloads["composite_fairing"] as? Dictionary<String,Any?>)
        let givenDiameter = try XCTUnwrap(givenCompositeFairing["diameter"] as? Dictionary<String,Any?>)
        let givenHeight = try XCTUnwrap(givenCompositeFairing["height"] as? Dictionary<String,Any?>)
        
        try XCTassertEqualsToAny(sut.secondStage?.burnTimeSEC, givenSecondStage["burn_time_sec"]!)
        try XCTassertEqualsToAny(sut.secondStage?.engines, givenSecondStage["engines"]!)
        try XCTassertEqualsToAny(sut.secondStage?.fuelAmountTons, givenSecondStage["fuel_amount_tons"]!)
        try XCTassertEqualsToAny(sut.secondStage?.reusable, givenSecondStage["reusable"]!)
            
        try XCTassertEqualsToAny(sut.secondStage?.thrust?.kN, givenThrust["kN"]!)
        try XCTassertEqualsToAny(sut.secondStage?.thrust?.lbf, givenThrust["lbf"]!)
        
        try XCTassertEqualsToAny(sut.secondStage?.payloads?.compositeFairing?.diameter?.feet, givenDiameter["feet"]!)
        try XCTassertEqualsToAny(sut.secondStage?.payloads?.compositeFairing?.diameter?.meters, givenDiameter["meters"]!)
            
        try XCTassertEqualsToAny(sut.secondStage?.payloads?.compositeFairing?.height?.feet, givenHeight["feet"]!)
        try XCTassertEqualsToAny(sut.secondStage?.payloads?.compositeFairing?.height?.meters, givenHeight["meters"]!)
        
        try XCTassertEqualsToAny(sut.secondStage?.payloads?.option1, givenPayloads["option_1"]!)
    }
    
    func test_decodable_setEngines() throws {
        let givenEngines = try XCTUnwrap(dictionary["engines"] as? Dictionary<String,Any?>)
        let givenIsp = try XCTUnwrap(givenEngines["isp"] as? Dictionary<String,Any?>)
        let givenThrustSeaLevel = try XCTUnwrap(givenEngines["thrust_sea_level"] as? Dictionary<String,Any?>)
        let givenThrustVacuum = try XCTUnwrap(givenEngines["thrust_vacuum"] as? Dictionary<String,Any?>)
        
        try XCTassertEqualsToAny(sut.engines?.engineLossMax, givenEngines["engine_loss_max"]!)
        try XCTassertEqualsToAny(sut.engines?.layout, givenEngines["layout"]!)
        try XCTassertEqualsToAny(sut.engines?.number, givenEngines["number"]!)
        try XCTassertEqualsToAny(sut.engines?.propellant1, givenEngines["propellant_1"]!)
        try XCTassertEqualsToAny(sut.engines?.propellant2, givenEngines["propellant_2"]!)
        try XCTassertEqualsToAny(sut.engines?.thrustToWeight, givenEngines["thrust_to_weight"]!)
            
        try XCTassertEqualsToAny(sut.engines?.isp?.seaLevel, givenIsp["sea_level"]!)
        try XCTassertEqualsToAny(sut.engines?.isp?.vacuum, givenIsp["vacuum"]!)
        
        try XCTassertEqualsToAny(sut.engines?.thrustSeaLevel?.kN, givenThrustSeaLevel["kN"]!)
        try XCTassertEqualsToAny(sut.engines?.thrustSeaLevel?.lbf, givenThrustSeaLevel["lbf"]!)
        
        try XCTassertEqualsToAny(sut.engines?.thrustVacuum?.kN, givenThrustVacuum["kN"]!)
        try XCTassertEqualsToAny(sut.engines?.thrustVacuum?.lbf, givenThrustVacuum["lbf"]!)
        
    }
    func test_decodable_setLandinLegs() throws {
        let givenLandingLegs = try XCTUnwrap(dictionary["landing_legs"] as? Dictionary<String,Any?>)
        
        try XCTassertEqualsToAny(sut.landingLegs?.material, givenLandingLegs["material"]!)
        try XCTassertEqualsToAny(sut.landingLegs?.number, givenLandingLegs["number"]!)
    }
    
    func test_decodable_setPayloadWeights() throws {
        let givenPayloadWeights = try XCTUnwrap(dictionary["payload_weights"] as? Array<Dictionary<String, Any>>)
        let givenFirstPayloadWeights = givenPayloadWeights.first
        
        try XCTassertEqualsToAny(sut.payloadWeights.first?.id, givenFirstPayloadWeights?["id"])
        try XCTassertEqualsToAny(sut.payloadWeights.first?.kg, givenFirstPayloadWeights?["kg"])
        try XCTassertEqualsToAny(sut.payloadWeights.first?.lb, givenFirstPayloadWeights?["lb"])
        try XCTassertEqualsToAny(sut.payloadWeights.first?.name, givenFirstPayloadWeights?["name"])
    }
    
    func test_decodable_setFlickrImages() throws {
        try XCTassertEqualsToAny(sut.flickrImages, dictionary["flickr_images"])
    }
    
    func test_decodable_setName() throws {
        try XCTassertEqualsToAny(sut.name, dictionary["name"])
    }
    
    func test_decodable_setType() throws {
        try XCTassertEqualsToAny(sut.type, dictionary["type"])
    }
    
    func test_decodable_setActive() throws {
        try XCTassertEqualsToAny(sut.active, dictionary["active"])
    }
    
    func test_decodable_setStages() throws {
        try XCTassertEqualsToAny(sut.stages, dictionary["stages"])
    }
    
    func test_decodable_setBoosters() throws {
        try XCTassertEqualsToAny(sut.boosters, dictionary["boosters"])
    }
    
    func test_decodable_setCostPerLaunch() throws {
        try XCTassertEqualsToAny(sut.costPerLaunch, dictionary["cost_per_launch"])
    }
    
    func test_decodable_setSuccessRatePct() throws {
        try XCTassertEqualsToAny(sut.successRatePct, dictionary["success_rate_pct"])
    }
    
    func test_decodable_setFirstFlight() throws {
        try XCTassertEqualsToAny(sut.firstFlight, dictionary["first_flight"])
    }
    
    func test_decodable_setCountry() throws {
        try XCTassertEqualsToAny(sut.country, dictionary["country"])
    }
    
    func test_decodable_setCompany() throws {
        try XCTassertEqualsToAny(sut.company, dictionary["company"])
    }
    
    func test_decodable_setWikipedia() throws {
        try XCTassertEqualsToAny(sut.wikipedia, dictionary["wikipedia"])
    }
    
    func test_decodable_setWelcomeDescription() throws {
        try XCTassertEqualsToAny(sut.welcomeDescription, dictionary["description"])
    }
    
    func test_decodable_setId() throws {
        try XCTassertEqualsToAny(sut.id, dictionary["id"])
    }
}

