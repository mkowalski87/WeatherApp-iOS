//
//  SearchLocationViewModel.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

struct SearchLocationModel {
    let title: String
    let temp: String
}

class SearchLocationViewModel: SearchLocationViewModelProtocol {
    
    var viewDelegate: SearchLocationViewDelegate?
    var locationDAO: LocationDAOProtocol = LocationDAO()
    var weatherDAO: WeatherDAOProtocol = WeatherDAO()
    var apiManager: APIManager = APIManager()
    var locations: [Location] = []
    
    var numberOfLocations: Int {
        return locations.count
    }

    func get(index: Int) -> SearchLocationModel {
        let loc = locations[index]
        var temp: String = "---"
        if let weather = loc.weatherEntries?.anyObject() as? Weather {
            temp = String(Int(weather.maxTemp))
        }

        return SearchLocationModel(title: loc.title, temp: temp)
    }
    
    func refresh() {
        locations = locationDAO.all(context: CoreDataHelper.instance.context) ?? []
        viewDelegate?.update(sender: self)
    }
    
    func addLocation(location: LocationDTO) {
        locationDAO.addOrUpdate(locationDTO: location, context: CoreDataHelper.instance.context)
        refresh()
    }
    
    func fetchWeather(for location: LocationDTO) {
        apiManager.getCurrentWeather(for: location.woeid) { (weatherList, error) -> (Void) in
            self.saveWeatherList(locationId: location.woeid, weatherList: weatherList!)
            self.refresh()
        }
    }
    
    private func saveWeatherList(locationId: Int32, weatherList: [WeatherDTO]) {
        let context = CoreDataHelper.instance.context
        if let location = self.locationDAO.get(locationId: locationId, context: context) {
            weatherList.forEach({
                self.weatherDAO.add(weatherDTO: $0, context: context).location = location
            })
            try? context.save()
        }
    }
}
