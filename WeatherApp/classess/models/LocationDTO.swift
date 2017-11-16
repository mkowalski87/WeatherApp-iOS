//
//  LocationDTO.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

struct LocationDTO: Codable, ParserProtocol {
    let title: String
    let location_type: String
    let woeid: Int32
    let latt_long: String
    
    var longitude: Double {
        return Double(latt_long.components(separatedBy: ",").last?.trimmingCharacters(in: .whitespaces) ?? "0.0") ?? 0.0
    }
    
    var latitude: Double {
        return Double(latt_long.components(separatedBy: ",").first?.trimmingCharacters(in: .whitespaces) ?? "0.0") ?? 0.0
    }
    
}
