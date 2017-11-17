//
//  WeatherDTOTests.swift
//  WeatherAppTests
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import XCTest

@testable import WeatherApp

class WeatherDTOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let stringJSON = """
                        {
                        "consolidated_weather": [
                        {
                        "id": 4955448545378304,
                        "weather_state_name": "Heavy Cloud",
                        "weather_state_abbr": "hc",
                        "wind_direction_compass": "WNW",
                        "created": "2017-11-16T20:28:03.679150Z",
                        "applicable_date": "2017-11-16",
                        "min_temp": 3.6579999999999999,
                        "max_temp": 13.359999999999999,
                        "the_temp": 12.640000000000001,
                        "wind_speed": 3.8120458384108802,
                        "wind_direction": 289.92960386235785,
                        "air_pressure": 1025.3699999999999,
                        "humidity": 79,
                        "visibility": 7.1973425196850389,
                        "predictability": 71
                        },
                        {
                        "id": 5477413773377536,
                        "weather_state_name": "Light Cloud",
                        "weather_state_abbr": "lc",
                        "wind_direction_compass": "WNW",
                        "created": "2017-11-16T20:28:04.471150Z",
                        "applicable_date": "2017-11-17",
                        "min_temp": 1.9400000000000002,
                        "max_temp": 8.6980000000000004,
                        "the_temp": 8.0449999999999999,
                        "wind_speed": 3.2526751020520166,
                        "wind_direction": 283.73873226958943,
                        "air_pressure": 1033.02,
                        "humidity": 73,
                        "visibility": 6.4672313688061713,
                        "predictability": 70
                        }
                        ],
                        "time": "2017-11-16T20:31:41.972470Z",
                        "sun_rise": "2017-11-16T07:20:26.529888Z",
                        "sun_set": "2017-11-16T16:09:36.900089Z",
                        "timezone_name": "LMT",
                        "parent": {
                        },
                        "sources": [
                        ],
                        "title": "London",
                        "location_type": "City",
                        "woeid": 44418,
                        "latt_long": "51.506321,-0.12714",
                        "timezone": "Europe/London"
                        }
                        """
        let jsonData = stringJSON.data(using: .utf8)!
        let parsedObject = GetWeatherResponse.parseObject(data: jsonData)
        XCTAssertNotNil(parsedObject)
        XCTAssertTrue(parsedObject?.consolidated_weather.count == 2)
        XCTAssertNotNil(parsedObject?.consolidated_weather.first?.created)
    }
}
