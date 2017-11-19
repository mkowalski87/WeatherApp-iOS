//
//  SearchLocationViewModel.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

struct SearchLocationModel {
    let title: String
    let temp: String
    let icon: UIImage?
}

class SearchLocationViewModel: SearchLocationViewModelProtocol {
    
    var viewDelegate: SearchLocationViewDelegate?
    var coordinatorDelegate: SearchLocationCoordinatorDelegate?
    
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
        var icon: UIImage?
        if let weather = weatherDAO.getLatestWeather(for: loc, date: Date()) {
            debugPrint("\(weather.created)")
            temp = "\(Int(weather.maxTemp)) ℃"
            icon = UIImage(named: weather.icon)
        }
        return SearchLocationModel(title: loc.title, temp: temp, icon: icon)
    }
    
    func refresh() {
        locations = locationDAO.all(context: CoreDataHelper.instance.context) ?? []
        viewDelegate?.update(sender: self)
    }
    
    func addLocation(location: LocationDTO) {
        locationDAO.addOrUpdate(locationDTO: location, context: CoreDataHelper.instance.context)
        refresh()
    }
    
    func isFavourite(index: Int) -> Bool {
        return locations[index].favourite
    }
    
    func addToFavourite(index: Int) {
        locationDAO.editFavourite(location: locations[index], favourite: true)
        viewDelegate?.update(sender: self)
    }
    
    func removeFromFavourite(index: Int) {
        locationDAO.editFavourite(location: locations[index], favourite: false)
        viewDelegate?.update(sender: self)
    }
    
    func close() {
        coordinatorDelegate?.close(sender: self)
    }
    
    func fetchWeather(for location: LocationDTO) {
        apiManager.getCurrentWeather(for: location.woeid) { (weatherList, error) -> (Void) in
            guard let weatherList = weatherList else {
                return
            }
            self.saveWeatherList(locationId: location.woeid, weatherList: weatherList)
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
