//
//  LocationListViewModelProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 15/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

protocol LocationListViewModelCoordinatorDelegate: class {
    func didSelectLocation(location: LocationDTO, sender: LocationListViewModelProtocol)
}

protocol LocationListViewDelegate: class {
    func update()
}

protocol LocationListViewModelProtocol: class {
    var numberOfLocations: Int { get }
    var viewDelegate: LocationListViewDelegate? { get set }
    var coordinatorDelegate: LocationListViewModelCoordinatorDelegate? { get set }
    
    func title(index: Int) -> String
    func select(index: Int)
    func refresh()
}
