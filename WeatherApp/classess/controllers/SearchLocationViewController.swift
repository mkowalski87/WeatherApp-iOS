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
    var viewModel: SearchLocationViewModelProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("not implemented yet")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search location"
        setupUI()
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTouched(sender:)))
        navigationItem.leftBarButtonItem = closeButton
        
        tableView.register(SearchLocationCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .green
        viewModel?.refresh()
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
    
    @objc func closeButtonTouched(sender: UIBarButtonItem) {
        viewModel?.close()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfLocations ?? 0
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let viewModel = viewModel else {
            return nil
        }
        
        let addToFavAction = UITableViewRowAction(style: .normal, title: "Add to favourite") { (action, indexPath) in
            viewModel.addToFavourite(index: indexPath.row)
        }
        addToFavAction.backgroundColor = .green
        
        let removeFromFavAction = UITableViewRowAction(style: .destructive, title: "Remove favourite") { (action, indexPath) in
            viewModel.removeFromFavourite(index: indexPath.row)
        }
        removeFromFavAction.backgroundColor = .blue
        return viewModel.isFavourite(index: indexPath.row) ? [removeFromFavAction] : [addToFavAction]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchLocationCell{
            if let model = viewModel?.get(index: indexPath.row) {
                cell.titleLabel.text = model.title
                cell.iconImageView.image = model.icon
                cell.tempLabel.text = model.temp
            }
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
        viewModel?.addLocation(location: location)
        viewModel?.fetchWeather(for: location)
    }
}

extension SearchLocationViewController: SearchLocationViewDelegate {
    
    func update(sender: SearchLocationViewModelProtocol) {
        tableView.reloadData()
    }
    
}
