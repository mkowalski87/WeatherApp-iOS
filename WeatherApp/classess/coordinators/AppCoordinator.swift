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
        let mainViewController = MainViewController()
        let vc1 = ListViewController()
        let vc2 = FavouritesViewController()
        mainViewController.viewControllers = [vc1,vc2]
        let navViewController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navViewController
    }
//
//    func showProjectDetails(project: Project) {
//        guard let projectDetailsViewController = ProjectDetailsViewController.loadFromStoryboard(),
//            let navVC = window.rootViewController as? UINavigationController else {
//                return
//        }
//
//        let projectDetailsViewModel = ProjectDetailsViewModel(project: project)
//        projectDetailsViewModel.coordinatorDelegate = self
//        projectDetailsViewController.viewModel = projectDetailsViewModel
//
//        navVC.pushViewController(projectDetailsViewController, animated: true)
//    }
//
//    func showDocuments(for project: Project) {
//        guard let navVC = window.rootViewController as? UINavigationController else {
//            return
//        }
//
//        documentsCoordinator = DocumentsCoordinator(baseViewController: navVC, project: project)
//        documentsCoordinator?.parentCoordinator = self
//        documentsCoordinator?.start()
//
//    }
    
    func start() {
        showMainView()
    }
    
    func finish() {
        //do nothing
    }
    
}

