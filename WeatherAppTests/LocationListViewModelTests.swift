//
//  LocationListViewModelTests.swift
//  WeatherAppTests
//
//  Created by Michał Kowalski on 15/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import XCTest

@testable import WeatherApp

class LocationListViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class MockViewModelDelegate: LocationListViewDelegate, LocationListViewModelCoordinatorDelegate {
        
        var selectedLocation: LocationDTO?
        var updated = false
        
        func update() {
            updated = true
        }
        
        func didSelectLocation(location: LocationDTO, sender: LocationListViewModelProtocol) {
            selectedLocation = location
        }
    }
    
    func testLocationListViewModel() {
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
        let list = LocationDTO.parseArray(data: jsonData)
        let viewModel = LocationListViewModel(locations: list!)
        let mockDelegate = MockViewModelDelegate()
        viewModel.viewDelegate = mockDelegate
        viewModel.coordinatorDelegate = mockDelegate
        XCTAssertEqual(viewModel.numberOfLocations, list?.count)
        XCTAssertEqual(viewModel.title(index: 0), "San Francisco")
        XCTAssertEqual(viewModel.title(index: 1), "San Diego")
        
        XCTAssertFalse(mockDelegate.updated)
        viewModel.refresh()
        XCTAssertTrue(mockDelegate.updated)
        
        viewModel.select(index: 2)
        XCTAssertEqual(mockDelegate.selectedLocation?.title , list?.last?.title)
    }

}
