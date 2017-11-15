//
//  NetworkingTests.swift
//  WeatherAppTests
//
//  Created by Michał Kowalski on 15/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import XCTest

@testable import WeatherApp

class NetworkingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchLocationRequest() {
        let apiRequest = APIRequest(endpoint: APIEndpoint.searchLocation(query: "War"))
        XCTAssertEqual(apiRequest.url.absoluteString, "https://www.metaweather.com/api/location/search?query=War")
    }
    
    func testCallSearchRequest() {
        let apiManager = APIManager()
        let callExpectation = expectation(description: "call request expectation")
        
        apiManager.searchLocations(with: "War") { (locations, error) -> (Void) in
            XCTAssertNil(error)
            XCTAssertNotNil(locations)
            XCTAssertEqual(locations?.count, 2)
            callExpectation.fulfill()
        }
        
        wait(for: [callExpectation], timeout: 5.0)
    }
}
