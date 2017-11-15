//
//  LocationListViewModel.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 15/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

class LocationListViewModel: LocationListViewModelProtocol {
    var locations: [LocationDTO] = []
    weak var viewDelegate: LocationListViewDelegate?
    weak var coordinatorDelegate: LocationListViewModelCoordinatorDelegate?
    
    init(locations: [LocationDTO]) {
        self.locations = locations
    }
    
    var numberOfLocations: Int {
        return locations.count
    }
    
    func title(index: Int) -> String {
        return locations[index].title
    }
    
    func select(index: Int) {
        coordinatorDelegate?.didSelectLocation(location: locations[index], sender: self)
    }
    
    func refresh() {
        viewDelegate?.update()
    }
}
