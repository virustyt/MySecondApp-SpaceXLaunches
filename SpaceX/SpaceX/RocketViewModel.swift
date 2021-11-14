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
    let wikipedia: URL?
    let welcomeDescription: String
    let id: String?
    
    init(rocket: Rocket){
        self.rocket = rocket
        self.height = rocket.height?.meters == nil ? "no info" : "\(Decimal( rocket.height!.meters!)) meters"
        self.diameter = rocket.diameter?.meters == nil ? "no info" : "\(Decimal(rocket.diameter!.meters!)) meters"
        self.mass = rocket.mass?.kg == nil ? "no info" : "\(rocket.mass!.kg!) kg"
        self.firstStage = FirstStageViewModel(rocket)
        self.secondStage = SecondStageViewModel(rocket)
        self.engines = EnginesViewModel(rocket)
        self.landingLegs = LandingLegsViewModel(rocket)
        self.flickrImages = RocketViewModel.flickrImages(rocket)
        self.name = rocket.name == nil ? "no info" : "\(rocket.name!)"
        self.costPerLaunch = rocket.costPerLaunch == nil ? "no info" : "\(rocket.costPerLaunch!)$"
        self.successRatePct = rocket.successRatePct == nil ? "no info" : "\(rocket.successRatePct!)%"
        self.firstFlight = RocketViewModel.firstFlight(rocket)
        self.wikipedia = rocket.wikipedia == nil ? nil : URL(string: rocket.wikipedia!)
        self.welcomeDescription = rocket.welcomeDescription == nil ? "Sorry, there is no info yet." : rocket.welcomeDescription!
        self.id = rocket.id == nil ? nil : rocket.id!
    }
    
    static func flickrImages(_ rocket:Rocket) -> [URL]{
        var flickrImages = [URL]()
        guard let imageURLArray = rocket.flickrImages else { return flickrImages}
        for stringUrl in imageURLArray {
            flickrImages.append(URL(string: stringUrl)!)
        }
        return flickrImages
    }
    
    static func firstFlight(_ rocket: Rocket) -> String {
        guard let firstFlightString = rocket.firstFlight else { return "no info" }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: firstFlightString) else { return "" }
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
            self.thrustSeaLevel = rocket.firstStage?.thrustSeaLevel?.kN == nil ? "no info" : "\(rocket.firstStage!.thrustSeaLevel!.kN!) kN"
            self.thrustVacuum = rocket.firstStage?.thrustVacuum?.kN == nil ? "no info" : "\(rocket.firstStage!.thrustVacuum!.kN!) kN"
            if let reus = rocket.firstStage?.reusable {
                self.reusable = reus ? "Yes" : "No"
            } else { self.reusable = "no info" }
            self.engines = rocket.firstStage?.engines == nil ? "no info" : "\(rocket.firstStage!.engines!)"
            self.fuelAmountTons = rocket.firstStage?.fuelAmountTons == nil ? "no info" : "\(rocket.firstStage!.fuelAmountTons!) tons"
            self.burnTimeSEC = rocket.firstStage?.burnTimeSEC == nil ? "no info" : "\(rocket.firstStage!.burnTimeSEC!) seconds"
        }
    }
    
    struct SecondStageViewModel{
        let thrust: String
        let reusable: String
        let engines: String
        let fuelAmountTons: String
        let burnTimeSEC: String
        
        init(_ rocket: Rocket){
            self.thrust = rocket.secondStage?.thrust?.kN == nil ? "no info" : "\(rocket.secondStage!.thrust!.kN!) kN"
            if let recieverReusable = rocket.secondStage?.reusable {
                self.reusable = Bool( recieverReusable ) ? "Yes" : "No"
            } else { self.reusable = "no info" }
            self.engines = rocket.secondStage?.engines == nil ? "no info" : "\(rocket.secondStage!.engines!)"
            self.fuelAmountTons = rocket.secondStage?.fuelAmountTons == nil ? "no info" : "\(rocket.secondStage!.fuelAmountTons!) tons"
            self.burnTimeSEC = rocket.secondStage?.burnTimeSEC == nil ? "no info" : "\(rocket.secondStage!.burnTimeSEC!) seconds"
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
            self.number = rocket.engines?.number == nil ? "no info" : "\(rocket.engines!.number!)"
            self.type = rocket.engines?.type ?? "no info"
            self.version = rocket.engines?.version ?? "no info"
            self.layout = rocket.engines?.layout ?? "no info"
            self.propellant1 = rocket.engines?.propellant1 ?? "no info"
            self.propellant2 = rocket.engines?.propellant2 ?? "no info"
        }
    }
    
    struct LandingLegsViewModel {
        let number: String
        let material: String
        
        init(_ rocket: Rocket){
            self.number = rocket.landingLegs?.number == nil ? "no info" : "\(rocket.landingLegs!.number!)"
            self.material = rocket.landingLegs?.material ?? "no info"
        }
    }
    
    func setUpCell(cell: RocketsTableViewCell){
        
    }
}

extension RocketViewModel: Equatable {
    static func == (lhs: RocketViewModel, rhs: RocketViewModel) -> Bool {
        return (lhs.rocket == rhs.rocket)
    }
}
