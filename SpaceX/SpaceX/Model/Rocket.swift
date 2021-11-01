//
//  Rocket.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 19.10.2021.
//

import Foundation

// MARK: - Welcome
struct Rocket: Codable, Equatable {
    let height, diameter: MetersAndFeets
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name, type: String
    let active: Bool
    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight, country, company: String
    let wikipedia: String
    let welcomeDescription, id: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegs = "landing_legs"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name, type, active, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, wikipedia
        case welcomeDescription = "description"
        case id
    }
}

// MARK: - Diameter
struct MetersAndFeets: Codable, Equatable {
    let meters, feet: Double
}

// MARK: - Engines
struct Engines: Codable, Equatable {
    let isp: ISP
    let thrustSeaLevel, thrustVacuum: Thrust
    let number: Int
    let type, version, layout: String
    let engineLossMax: Int
    let propellant1, propellant2: String
    let thrustToWeight: Double

    enum CodingKeys: String, CodingKey {
        case isp
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case number, type, version, layout
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustToWeight = "thrust_to_weight"
    }
}

// MARK: - ISP
struct ISP: Codable, Equatable {
    let seaLevel, vacuum: Int

    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case vacuum
    }
}

// MARK: - Thrust
struct Thrust: Codable,Equatable {
    let kN, lbf: Int
}

// MARK: - FirstStage
struct FirstStage: Codable, Equatable {
    let thrustSeaLevel, thrustVacuum: Thrust
    let reusable: Bool
    let engines, fuelAmountTons, burnTimeSEC: Int

    enum CodingKeys: String, CodingKey {
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - LandingLegs
struct LandingLegs: Codable, Equatable {
    let number: Int
    let material: String
}

// MARK: - Mass
struct Mass: Codable, Equatable {
    let kg, lb: Int
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable, Equatable {
    let id, name: String
    let kg, lb: Int
}

// MARK: - SecondStage
struct SecondStage: Codable, Equatable {
    let thrust: Thrust
    let payloads: Payloads
    let reusable: Bool
    let engines, fuelAmountTons, burnTimeSEC: Int

    enum CodingKeys: String, CodingKey {
        case thrust, payloads, reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - Payloads
struct Payloads: Codable, Equatable {
    let compositeFairing: CompositeFairing
    let option1: String

    enum CodingKeys: String, CodingKey {
        case compositeFairing = "composite_fairing"
        case option1 = "option_1"
    }
}

// MARK: - CompositeFairing
struct CompositeFairing: Codable, Equatable {
    let height, diameter: MetersAndFeets
}

