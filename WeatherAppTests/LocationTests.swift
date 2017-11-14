//
//  LocationTests.swift
//  WeatherAppTests
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import XCTest

@testable import WeatherApp

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParsingObjectLocationDTO() {
        let stringJSON = "{\"title\": \"San Francisco\",\"location_type\": \"City\",\"woeid\": 2487956,\"latt_long\": \"37.777119, -122.41964\"}"
        let jsonData = stringJSON.data(using: .utf8)!
        let location = LocationDTO.parseObject(data: jsonData)
        XCTAssertNotNil(location)
        XCTAssertEqual(location?.title, "San Francisco")
        XCTAssertEqual(location?.woeid, 2487956)
        XCTAssertEqual(Int(location!.latitude), 37)
        XCTAssertEqual(Int(location!.longitude), -122)
    }
    
    func testParsingArray() {
        let stringJSON = """
                            [{
                            "title": "San Francisco",
                            "location_type": "City",
                            "woeid": 2487956,
                            "latt_long": "37.777119, -122.41964"
                            },
                            {
                                "title": "San Diego",
                                "location_type": "City",
                                "woeid": 2487889,
                                "latt_long": "32.715691,-117.161720"
                            },
                            {
                                "title": "San Jose",
                                "location_type": "City",
                                "woeid": 2488042,
                                "latt_long": "37.338581,-121.885567"
                            }]
                          """
        let jsonData = stringJSON.data(using: .utf8)!
        let array = LocationDTO.parseArray(data: jsonData)
        XCTAssertNotNil(array)
        XCTAssertEqual(array!.count, 3)
    }
}
