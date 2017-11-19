//
//  FavouritesViewController.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 14/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    var tableView = UITableView()
    var viewModel: FavouritesViewModelProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("not implemented yet")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        let addButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(addLocationButtonTouched(sender:)))
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .yellow
        setupUI()
        tableView.register(SearchLocationCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.refresh()
    }
    
    @objc func addLocationButtonTouched(sender: UIBarButtonItem) {
        viewModel?.showSearchLocation()
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
    }
}

extension FavouritesViewController: FavouritesViewDelegate {
    func update(sender: FavouritesViewModelProtocol) {
        tableView.reloadData()
    }
}

extension  FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfPlaces ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchLocationCell,
            let model = viewModel?.location(index: indexPath.row) {
            cell.tempLabel.text = model.temp
            cell.titleLabel.text = model.title
            return cell
        }
        return UITableViewCell()
    }
}
