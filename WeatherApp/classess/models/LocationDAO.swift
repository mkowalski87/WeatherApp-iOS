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
    
    func get(locationId: Int32, context: NSManagedObjectContext) -> Location? {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "locationId == %d", locationId)
        return (try? context.fetch(request))?.first
    }
    
    func all(context: NSManagedObjectContext) -> [Location]? {
        do {
            let request: NSFetchRequest<Location> = Location.fetchRequest()
            return try context.fetch(request)
        } catch let e {
            debugPrint(e)
            return nil
        }
    }
    
    func add(location: LocationDTO, context: NSManagedObjectContext) -> Location {
        let locationObj = Location(context: context)
        locationObj.locationId = location.woeid
        locationObj.copyValues(from: location)
        try? context.save()
        return locationObj
    }
    
    
    func addOrUpdate(locationDTO: LocationDTO, context: NSManagedObjectContext) {
        if let location = self.get(locationId: locationDTO.woeid, context: context) {
            location.copyValues(from: locationDTO)
            try? context.save()
        } else {
            _ = add(location: locationDTO, context: context)
        }
    }
}
