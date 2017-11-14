//
//  CoordinatorProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//
import UIKit

protocol CoordinatorProtocol: class {
    var topViewController: UIViewController? { get }
    //var childCoordinator: CoordinatorProtocol? { get }
    
    func start()
    func finish()
}
