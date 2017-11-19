//
//  FavouritesViewModelProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

struct FavouritesModel {
    let title: String
    let temp: String
    let icon: UIImage?
}

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
    func location(index: Int) -> FavouritesModel
    func showSearchLocation()
    func refresh()
}
