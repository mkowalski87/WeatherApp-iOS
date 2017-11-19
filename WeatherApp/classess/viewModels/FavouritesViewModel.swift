//
//  FavouritesViewModel.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

final class FavouritesViewModel: FavouritesViewModelProtocol {
    var viewDelegate: FavouritesViewDelegate?
    var coordinatorDelegate: FavouritesCoordinatorDelegate?
    var weatherDAO: WeatherDAOProtocol = WeatherDAO()
    var locationDAO: LocationDAOProtocol = LocationDAO()
    
    private var locations: [Location] = []
    
    var numberOfPlaces: Int {
        return locations.count
    }
    
    func location(index: Int) -> FavouritesModel {
        let loc = locations[index]
        var temp: String = "---"
        var icon: UIImage?
        if let weather = weatherDAO.getLatestWeather(for: loc, date: Date()) {
            temp = "\(Int(weather.maxTemp)) ℃"
            icon = UIImage(named: weather.icon)
        }
        return FavouritesModel(title: loc.title, temp: temp, icon: icon)
    }
    
    func refresh() {
        locations = locationDAO.getFavourited(context: CoreDataHelper.instance.context) ?? []
        viewDelegate?.update(sender: self)
    }
    
    func showSearchLocation() {
        coordinatorDelegate?.showSearchLocation(sender: self)
    }
    
}
