//
//  Weather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var weatherId: Int64
    @NSManaged public var weatherState: String?
    @NSManaged public var maxTemp: Double
    @NSManaged public var created: Date
    @NSManaged public var date: String
    @NSManaged public var location: Location?
    @NSManaged public var icon: String

}
