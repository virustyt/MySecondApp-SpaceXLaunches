//
//  XCTAssertEqualsToAny.swift
//  SpaceXTests
//
//  Created by Vladimir Oleinikov on 31.10.2021.
//

import XCTest

func XCTassertEqualsToAny<T: Equatable>(_ actual: @autoclosure () throws -> T,
                                        _ expected: @autoclosure () throws -> Any?,
                                        file: StaticString = #file, line: UInt = #line) throws {
    let actual = try actual()
    let expected = try XCTUnwrap(expected() as? T)
    XCTAssertEqual(actual, expected, file: file, line: line)
}

func XCTAssertEqualToDate(_ actual: @autoclosure () throws -> Date,
                          expected: @autoclosure () throws -> Any?,
                          file: StaticString = #file, line: UInt = #line) throws {
    let actual = try actual()
    let value = try expected()
    let expected: Date
    if let value = value as? TimeInterval {
        expected = Date(timeIntervalSinceReferenceDate: value)
    }
    else {
        expected = try XCTUnwrap(value as? Date)
    }
    XCTAssertEqual(actual, expected)
}

public func XCTAssertEqualToURL(_ actual: @autoclosure () throws -> URL,
                                _ expected: @autoclosure () throws -> Any?,
                                file: StaticString = #file,
                                line: UInt = #line) throws {

  let actual = try actual()
  let value = try XCTUnwrap(expected() as? String)
  let expected = try XCTUnwrap(URL(string: value))
  XCTAssertEqual(actual, expected, file: file, line: line)
}
