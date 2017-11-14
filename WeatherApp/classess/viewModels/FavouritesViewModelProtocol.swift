//
//  FavouritesViewModelProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

protocol FavouritesViewViewDelegate {
    func update(sender: FavouritesViewModelProtocol)
}

protocol FavouritesViewModelProtocol {
    
    var numberOfPlaces: Int { get }
    
    func locationName(index: Int) -> String

}
