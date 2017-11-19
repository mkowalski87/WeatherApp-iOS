//
//  LocationDAOProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit
import CoreData

protocol LocationDAOProtocol {
    func get(locationId: Int32, context: NSManagedObjectContext) -> Location?
    func add(location: LocationDTO, context: NSManagedObjectContext) -> Location
    func addOrUpdate(locationDTO: LocationDTO, context: NSManagedObjectContext)
    func all(context: NSManagedObjectContext) -> [Location]?
    func getFavourited(context: NSManagedObjectContext) -> [Location]?
    func editFavourite(location: Location, favourite: Bool)
}
