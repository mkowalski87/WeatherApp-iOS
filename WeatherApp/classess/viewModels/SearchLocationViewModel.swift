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
    
    var locations: [Location] = []
    
    var numberOfLocations: Int {
        return locations.count
    }

    func get(index: Int) -> SearchLocationModel {
        let loc = locations[index]
        return SearchLocationModel(title: loc.title, temp: "---")
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
        
    }
}
