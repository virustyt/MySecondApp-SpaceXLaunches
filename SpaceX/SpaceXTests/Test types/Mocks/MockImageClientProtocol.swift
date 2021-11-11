//
//  MockImageClientProtocol.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 11.11.2021.
//


@testable import SpaceX
import UIKit

class MockImageService: ImageClientProtocol{
    
    var setImageCallCount = 0
    var receivedImageView: UIImageView!
    var receivedURL: URL!
    var receivedPlaceholder: UIImage!
    
    func downloadImages(imageURL: URL, complition: @escaping (UIImage?, Error?) -> ()) -> URLSessionDataTask? {
        return nil
    }
    
    func setImage(on imageView: UIImageView, from imageURL: URL, with placeholder: UIImage?, complition: ((UIImage?, Error?) -> ())?) {
        setImageCallCount += 1
        receivedImageView = imageView
        receivedURL = imageURL
        receivedPlaceholder = placeholder
    }
}
