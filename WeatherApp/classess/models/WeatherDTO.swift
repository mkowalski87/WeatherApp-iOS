//
//  WeatherDTO.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

//{
//    "id": 6578316433686528,
//    "weather_state_name": "Heavy Cloud",
//    "weather_state_abbr": "hc",
//    "wind_direction_compass": "W",
//    "created": "2017-11-16T17:28:04.160310Z",
//    "applicable_date": "2017-11-16",
//    "min_temp": 3.742,
//    "max_temp": 13.291999999999998,
//    "the_temp": 12.640000000000001,
//    "wind_speed": 5.1060458384108802,
//    "wind_direction": 276.80034034180613,
//    "air_pressure": 1025.3699999999999,
//    "humidity": 79,
//    "visibility": 8.3561997932076668,
//    "predictability": 71
//},

struct WeatherDTO: Codable {
    let id: Int64
    let weather_state_name: String
    let created: String
    let max_temp: Double
}
