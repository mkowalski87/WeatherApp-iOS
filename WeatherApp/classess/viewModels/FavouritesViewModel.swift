//
//  FavouritesViewModel.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

final class FavouritesViewModel: FavouritesViewModelProtocol {
    
    private var locations: [Location] = []
    
    var numberOfPlaces: Int {
        return locations.count
    }
    
    func locationName(index: Int) -> String {
        return locations[index].title
    }
    
    
}
