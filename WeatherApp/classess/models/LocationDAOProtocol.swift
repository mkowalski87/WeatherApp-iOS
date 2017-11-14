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
    func add(locationDTO: LocationDTO, context: NSManagedObjectContext) -> Location
    func all(context: NSManagedObjectContext) -> [Location]?
}
