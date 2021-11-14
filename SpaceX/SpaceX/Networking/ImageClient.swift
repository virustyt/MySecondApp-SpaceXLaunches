//
//  ImageClient.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 04.11.2021.
//

import UIKit

protocol ImageClientProtocol{
    func downloadImages(imageURL: URL ,
                        complition: @escaping (UIImage?, Error?) -> ()) -> URLSessionDataTask?
    func setImage(on imageView: UIImageView,
                  from imageURL: URL,
                  with placeholder: UIImage?,
                  complition: ((UIImage?, Error?)-> ())?)
}

class ImageClient {
    var cashedImages: [URL: UIImage]
    var cashedDataTasks: [UIImageView: URLSessionDataTask]
    
    var urlSession: URLSession
    var responseQueue: DispatchQueue?
    
    static let shared = ImageClient(urlSession: URLSession.shared, responseQueue: .main)
    
    init(urlSession: URLSession, responseQueue: DispatchQueue?){
        self.urlSession = urlSession
        self.responseQueue = responseQueue
        
        self.cashedImages = [:]
        self.cashedDataTasks = [:]
    }
}

extension ImageClient: ImageClientProtocol{
    func downloadImages(imageURL: URL, complition: @escaping (UIImage?, Error?) -> ()) -> URLSessionDataTask? {
        if let cashedImage = self.cashedImages[imageURL] {
            dispatchResults(model: cashedImage, complitionHandler: complition)
            return nil
        }
        let dataTask = self.urlSession.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let self = self else { return }
            if let recievedData = data,
               let recievedImage = UIImage(data: recievedData) {
                self.cashedImages[imageURL] = recievedImage
                self.dispatchResults(model: recievedImage,complitionHandler: complition)
            }
            else{
                self.dispatchResults(error: error, complitionHandler: complition)
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    func setImage(on imageView: UIImageView, from imageURL: URL, with placeholder: UIImage?, complition: ((UIImage?, Error?)-> ())? = nil) {
        cashedDataTasks[imageView]?.cancel()
        imageView.image = placeholder
        cashedDataTasks[imageView] = downloadImages(imageURL: imageURL,
                                                    complition: {[weak self] image, error in
                                                        guard let self = self else {return}
                                                        self.cashedDataTasks[imageView] = nil
                                                        if let notNilImage = image {imageView.image = notNilImage}
                                                        guard complition != nil else { return }
                                                        complition!(image, error)
                                                    })
        }
    
    func dispatchResults<Type>(model: Type? = nil, error: Error? = nil, complitionHandler: @escaping (Type?,Error?) -> ()){
        guard let responseQueue = self.responseQueue
        else {
            complitionHandler(model,error)
            return
        }
        responseQueue.async { complitionHandler(model,error) }
    }
}
