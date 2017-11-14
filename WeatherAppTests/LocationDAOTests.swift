//
//  LocationDAOTests.swift
//  WeatherAppTests
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import XCTest

@testable import WeatherApp

class LocationDAOTests: XCTestCase {
    
    let locationDAO = LocationDAO()
    
    override func setUp() {
        
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        CoreDataHelper.instance.deleteAll()
    }
    
    func testAdding() {
        var loc = LocationDTO(title: "Krakow", location_type: "City", woeid: 1, latt_long: "22.0, 54.0")
        _ = locationDAO.add(locationDTO: loc, context: CoreDataHelper.instance.context)
        CoreDataHelper.instance.save()
        var locations = locationDAO.all(context: CoreDataHelper.instance.context)
        XCTAssertEqual(locations?.count, 1)
        loc = LocationDTO(title: "Rzeszow", location_type: "City", woeid: 2, latt_long: "22.5, 54.0")
        _ = locationDAO.add(locationDTO: loc, context: CoreDataHelper.instance.context)
        CoreDataHelper.instance.save()
        locations = locationDAO.all(context: CoreDataHelper.instance.context)
        XCTAssertEqual(locations?.count, 2)
    }

    
}
