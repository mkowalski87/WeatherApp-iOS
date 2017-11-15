//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

class SearchLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var tableView: UITableView!
    var searchController: UISearchController!
    var locationListVC = LocationListViewController()
    var apiManager = APIManager()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("not implemented yet")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .green
    }

    func setupUI() {
        
        // configure tableView
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        
        // add searchController
        searchController = UISearchController(searchResultsController: locationListVC)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = "aaaa"
            return cell
        }
        return UITableViewCell()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        apiManager.searchLocations(with: text) { (locations, error) -> (Void) in
            if let locationList = locations {
                let viewModel = LocationListViewModel(locations: locationList)
                viewModel.viewDelegate = self.locationListVC
                viewModel.coordinatorDelegate = self
                self.locationListVC.viewModel = viewModel
                viewModel.refresh()
            }
        }
    }
}

extension SearchLocationViewController: LocationListViewModelCoordinatorDelegate {
    func didSelectLocation(location: LocationDTO, sender: LocationListViewModelProtocol) {
        searchController.dismiss(animated: true, completion: nil)
        //store selected location
    }
}
