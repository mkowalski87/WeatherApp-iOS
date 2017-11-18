//
//  FavouritesViewModelProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

protocol FavouritesCoordinatorDelegate {
    func showSearchLocation(sender: FavouritesViewModelProtocol)
}
protocol FavouritesViewDelegate {
    func update(sender: FavouritesViewModelProtocol)
}

protocol FavouritesViewModelProtocol {
    var viewDelegate: FavouritesViewDelegate? { get set }
    var coordinatorDelegate: FavouritesCoordinatorDelegate? { get set }
    
    var numberOfPlaces: Int { get }
    
    func locationName(index: Int) -> String
    func showSearchLocation()
}
