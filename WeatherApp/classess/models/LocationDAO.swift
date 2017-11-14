//
//  LocationDAO.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit
import CoreData

class LocationDAO: LocationDAOProtocol {
    
    func all(context: NSManagedObjectContext) -> [Location]? {
        do {
            let request: NSFetchRequest<Location> = Location.fetchRequest()
            return try context.fetch(request)
        } catch let e {
            debugPrint(e)
            return nil
        }
    }
    
    func add(locationDTO: LocationDTO, context: NSManagedObjectContext) -> Location {
        let location = Location(context: context)
        location.locationId = locationDTO.woeid
        location.copyValues(from: locationDTO)
        return location
    }
    
    
//    func addOrUpdate(locationDTO: LocationDTO, context: NSManagedObjectContext) {
//        let request: NSFetchRequest<Location> = Location.fetchRequest()
//        request.fetchLimit = 1
//        request.predicate = NSPredicate(format: "locationId = %@", locationDTO.woeid)
//        if let location = (try? request.execute())?.first {
//
//        }
//    }
}
