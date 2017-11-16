//
//  WeatherDAO.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import CoreData

class WeatherDAO: WeatherDAOProtocol {
    func add(weatherDTO: WeatherDTO, context: NSManagedObjectContext) -> Weather {
        let obj = Weather(context: context)
        obj.weatherId = weatherDTO.id
        obj.weatherState = weatherDTO.weather_state_name
        obj.maxTemp = weatherDTO.max_temp
        try? context.save()
        return obj
    }
    
    func addOrUpdate(weatherDTO: WeatherDTO, context: NSManagedObjectContext) -> [Weather] {
        return []
    }
}
