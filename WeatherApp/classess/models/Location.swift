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

public class Location: NSManagedObject {

    func copyValues(from object: LocationDTO) {
        title = object.title
        lat = object.latitude
        lon = object.longitude
        type = object.location_type
    }
    
}
