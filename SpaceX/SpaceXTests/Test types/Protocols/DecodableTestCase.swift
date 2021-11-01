//
//  DecodableTestCase.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 30.10.2021.
//

import Foundation

protocol DecodableTestCase: AnyObject {
    associatedtype T: Decodable

    var sut: T! {get set}
    var dictionary: NSDictionary! { get set}
}
extension DecodableTestCase {

    func givenSutFromJSON(fileName: String = "\(T.self)",
                          file: StaticString = #file,
                          line: UInt = #line) throws {
        let data = try  Data.fromJson(fileName: fileName,file: file, line: line)

        dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
        
        sut = try JSONDecoder().decode(T.self, from: data)
    }
}


