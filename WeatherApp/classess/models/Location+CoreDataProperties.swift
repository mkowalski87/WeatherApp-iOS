//
//  Location+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var favourite: Bool
    @NSManaged public var lat: Double
    @NSManaged public var locationId: Int32
    @NSManaged public var lon: Double
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var weatherEntries: NSSet?

}

// MARK: Generated accessors for weatherEntries
extension Location {

    @objc(addWeatherEntriesObject:)
    @NSManaged public func addToWeatherEntries(_ value: Weather)

    @objc(removeWeatherEntriesObject:)
    @NSManaged public func removeFromWeatherEntries(_ value: Weather)

    @objc(addWeatherEntries:)
    @NSManaged public func addToWeatherEntries(_ values: NSSet)

    @objc(removeWeatherEntries:)
    @NSManaged public func removeFromWeatherEntries(_ values: NSSet)

}
