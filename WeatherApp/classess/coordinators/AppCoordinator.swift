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
        let navViewController = UINavigationController(rootViewController: SearchLocationViewController())
        window.rootViewController = navViewController
    }

    func start() {
        showMainView()
    }
    
    func finish() {
        //do nothing
    }
    
}

