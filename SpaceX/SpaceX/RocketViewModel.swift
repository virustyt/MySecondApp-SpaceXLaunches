//
//  RocketViewModel.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 01.11.2021.
//

import UIKit
//RocketViewModel hasnt get from Rocket: SecondStage.payloads,
//                                       Engines.ISP - thrustSeaLevel - thrustVacuum - thrustToWeight - thrustToWeight - engineLossMax,
//                                       payloadWeights, type, active, stages, boosters, country, company

class RocketViewModel{
    let rocket:Rocket
    
    let height: String
    let diameter: String
    let mass: String
    let firstStage: FirstStageViewModel
    let secondStage: SecondStageViewModel
    let engines: EnginesViewModel
    let landingLegs: LandingLegsViewModel
    let flickrImages: [URL]
    let name: String
    let costPerLaunch: String
    let successRatePct: String
    let firstFlight: String
    let wikipedia: URL
    let welcomeDescription, id: String
    
    init(rocket: Rocket){
        self.rocket = rocket
        self.height = "\(Decimal( rocket.height.meters)) meters"
        self.diameter = "\(Decimal(rocket.diameter.meters)) meters"
        self.mass = "\(rocket.mass.kg) kg"
        self.firstStage = FirstStageViewModel(rocket)
        self.secondStage = SecondStageViewModel(rocket)
        self.engines = EnginesViewModel(rocket)
        self.landingLegs = LandingLegsViewModel(rocket)
        self.flickrImages = RocketViewModel.flickrImages(rocket)
        self.name = rocket.name
        self.costPerLaunch = "\(rocket.costPerLaunch)$"
        self.successRatePct = "\(rocket.successRatePct)%"
        self.firstFlight = RocketViewModel.firstFlight(rocket)
        self.wikipedia = URL(string: rocket.wikipedia)!
        self.welcomeDescription = rocket.welcomeDescription
        self.id = rocket.id
    }
    
    static func flickrImages(_ rocket:Rocket) -> [URL]{
        var flickrImages = [URL]()
        for stringUrl in rocket.flickrImages {
            flickrImages.append(URL(string: stringUrl)!)
        }
        return flickrImages
    }
    
    static func firstFlight(_ rocket: Rocket) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: rocket.firstFlight) else { return "" }
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd, yyyy")
        return dateFormatter.string(from: date)
    }
}

extension RocketViewModel {
    
    struct FirstStageViewModel{
        let thrustSeaLevel: String
        let thrustVacuum: String
        let reusable: String
        let engines: String
        let fuelAmountTons: String
        let burnTimeSEC: String
        
        init(_ rocket: Rocket) {
            self.thrustSeaLevel = "\(rocket.firstStage.thrustSeaLevel.kN) kN"
            self.thrustVacuum = "\(rocket.firstStage.thrustVacuum.kN) kN"
            self.reusable = rocket.firstStage.reusable ? "Yes" : "No"
            self.engines = "\(rocket.firstStage.engines)"
            self.fuelAmountTons = "\(rocket.firstStage.fuelAmountTons) tons"
            self.burnTimeSEC = "\(rocket.firstStage.burnTimeSEC) seconds"
        }
    }
    
    struct SecondStageViewModel{
        let thrust: String
        let reusable: String
        let engines: String
        let fuelAmountTons: String
        let burnTimeSEC: String
        
        init(_ rocket: Rocket){
            self.thrust = "\(rocket.secondStage.thrust.kN) kN"
            self.reusable = rocket.secondStage.reusable ? "Yes" : "No"
            self.engines = "\(rocket.secondStage.engines)"
            self.fuelAmountTons = "\(rocket.secondStage.fuelAmountTons) tons"
            self.burnTimeSEC = "\(rocket.secondStage.burnTimeSEC) seconds"
        }
    }
    
    struct EnginesViewModel{
        let number: String
        let type: String
        let version: String
        let layout: String
        let propellant1: String
        let propellant2: String
        
        init(_ rocket: Rocket){
            self.number = "\(rocket.engines.number)"
            self.type = rocket.engines.type
            self.version = rocket.engines.version
            self.layout = rocket.engines.layout
            self.propellant1 = rocket.engines.propellant1
            self.propellant2 = rocket.engines.propellant2
        }
    }
    
    struct LandingLegsViewModel {
        let number: String
        let material: String
        
        init(_ rocket: Rocket){
            self.number = "\(rocket.landingLegs.number)"
            self.material = rocket.landingLegs.material
        }
    }
}
