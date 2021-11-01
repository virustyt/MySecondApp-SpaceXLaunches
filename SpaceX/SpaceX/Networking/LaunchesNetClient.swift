//
//  LaunchesNetClient.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 21.10.2021.
//

import Foundation


class LaunchesNetClient {
    enum SpaceXObject{
        case rockets
        case launches
        case launchpads
    }
    
    enum RequestError: Error{
        case noBaseURLExistsForSpaceXObject(object:SpaceXObject)
    }
    
    var baseUrls: [SpaceXObject: URL]
    var urlSession: URLSession
    var resopnseQueue: DispatchQueue? = nil
    
    init(baseUrls:[SpaceXObject: URL], urlSession: URLSession = URLSession.shared, responseQueue: DispatchQueue?){
        self.baseUrls = baseUrls
        self.urlSession = urlSession
        self.resopnseQueue = responseQueue
    }
    
    func getAllRockets(complition: @escaping ([Rocket]?, Error?) -> ()){
        guard let baseUrlForRockets = baseUrls[.rockets] else {return}
        let urlForRequest = URL(string: "rockets", relativeTo: baseUrlForRockets)!
        let dataTask = urlSession.dataTask(with: urlForRequest) { [weak self] data, response, error in
            guard let self = self else {return}
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode,
                  let data = data
            else {
                self.dispatchResults(error: error, complitionHandler: complition)
                return
            }
            do {
                let recievedRockets = try JSONDecoder().decode([Rocket].self, from: data)
                self.dispatchResults(model: recievedRockets, complitionHandler: complition)
                
            }
            catch {
                self.dispatchResults(error: error, complitionHandler: complition)
            }
        }
        dataTask.resume()
    }
    
    func dispatchResults<Type>(model: Type? = nil, error: Error? = nil, complitionHandler: @escaping (Type?,Error?) -> ()){
        guard let responseQueue = self.resopnseQueue
        else {
            complitionHandler(model,error)
            return
        }
        responseQueue.async { complitionHandler(model,error) }

    }
}

