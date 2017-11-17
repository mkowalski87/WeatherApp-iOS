//
//  WeatherDAO.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import CoreData

class WeatherDAO: WeatherDAOProtocol {
    static let apiDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    func add(weatherDTO: WeatherDTO, context: NSManagedObjectContext) -> Weather {
        let obj = Weather(context: context)
        obj.weatherId = weatherDTO.id
        obj.weatherState = weatherDTO.weather_state_name
        obj.created = weatherDTO.created
        obj.date = weatherDTO.applicable_date
        obj.maxTemp = weatherDTO.max_temp
        obj.icon = weatherDTO.weather_state_abbr
        try? context.save()
        return obj
    }
    
    func addOrUpdate(weatherDTO: WeatherDTO, context: NSManagedObjectContext) -> [Weather] {
        return []
    }
    
    func getLatestWeather(for location: Location, date: Date) -> Weather? {
        let request: NSFetchRequest<Weather> = Weather.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "location == %@ && date == %@", location, WeatherDAO.apiDateFormatter.string(from: date))
        request.sortDescriptors = [NSSortDescriptor(key: "created", ascending: false)]
        do {
            return try location.managedObjectContext?.fetch(request).first
        } catch _ {
            return nil
        }
    }
}
