//
//  Location+CoreDataClass.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//
//

import Foundation
import CoreData

struct LocationDTO: Codable {
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
    
    static func parseObject(data: Data) -> LocationDTO? {
        let decoder = JSONDecoder()
        return try? decoder.decode(LocationDTO.self, from: data)
    }
    
    static func parseArray(data: Data) -> [LocationDTO]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([LocationDTO].self, from: data)
    }
    
}

public class Location: NSManagedObject {

    func copyValues(from object: LocationDTO) {
        title = object.title
        lat = object.latitude
        lon = object.longitude
        type = object.location_type
    }
    
}
