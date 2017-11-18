//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {

    // MARK: - properties
    let window: UIWindow

    var topViewController: UIViewController? {
        guard let navVC = window.rootViewController as? UINavigationController else {
            return nil
        }
        return navVC.viewControllers.last
    }
    
    // MARK: - Inits
    init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Public methods
    func showMainView() {
        window.rootViewController = showFavourites()
    }

    func showSearchLocation() {
        let searchLocVC = SearchLocationViewController()
        let viewModel = SearchLocationViewModel()
        viewModel.viewDelegate = searchLocVC
        viewModel.coordinatorDelegate = self
        searchLocVC.viewModel = viewModel
        let navVC = UINavigationController(rootViewController: searchLocVC)
        topViewController?.present(navVC, animated: true, completion: nil)
    }
    
    func showFavourites() -> UIViewController {
        let favLocVC = FavouritesViewController()
        let viewModel = FavouritesViewModel()
        viewModel.viewDelegate = favLocVC
        viewModel.coordinatorDelegate =  self
        favLocVC.viewModel = viewModel
        let navVC = UINavigationController(rootViewController: favLocVC)
        return navVC
    }
    
    func start() {
        showMainView()
    }
    
    func finish() {
        //do nothing
    }
    
}

extension AppCoordinator: FavouritesCoordinatorDelegate {
    func showSearchLocation(sender: FavouritesViewModelProtocol) {
        showSearchLocation()
    }
}

extension AppCoordinator: SearchLocationCoordinatorDelegate {
    func close(sender: SearchLocationViewModelProtocol) {
        topViewController?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
