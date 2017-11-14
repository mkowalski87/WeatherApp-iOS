//
//  Location+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var locationId: Int32
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var title: String
    @NSManaged public var type: String

}
