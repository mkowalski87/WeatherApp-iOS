//
//  SearchLocationViewModelProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

protocol SearchLocationViewDelegate {
    func update(sender: SearchLocationViewModelProtocol)
}

protocol SearchLocationViewModelProtocol {
    var viewDelegate: SearchLocationViewDelegate? { get set }
    var numberOfLocations: Int { get }
    func refresh()
    func addLocation(location: LocationDTO)
    func fetchWeather(for location: LocationDTO)
    func get(index: Int) -> SearchLocationModel
}
