//
//  WeatherDAOProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit
import CoreData

protocol WeatherDAOProtocol {
    func add(weatherDTO: WeatherDTO, context: NSManagedObjectContext) -> Weather
    func addOrUpdate(weatherDTO: WeatherDTO, context: NSManagedObjectContext) -> [Weather]
    func getLatestWeather(for location: Location, date: Date) -> Weather?
}
