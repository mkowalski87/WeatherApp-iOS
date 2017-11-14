//
//  CoordinatorTests.swift
//  WeatherAppTests
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import XCTest

@testable import WeatherApp

class CoordinatorTests: XCTestCase {
    
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIApplication.shared.keyWindow
        window.rootViewController = nil
    }
    
    override func tearDown() {
        super.tearDown()
        window.rootViewController = nil
        window = nil
    }
    
    func testShowMainVC() {
        let appCoord = AppCoordinator(window: window)
        appCoord.start()
        let mainVC = appCoord.topViewController as? MainViewController
        XCTAssertNotNil(mainVC)
        XCTAssertEqual(mainVC?.viewControllers?.count, 2)
    }
}
