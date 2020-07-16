//
//  PlacesListViewController.swift
//  MyPlaces
//
//  Created by Максим Семений on 12.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit
import CoreLocation

final class PlacesListViewController: UIViewController {
    
    let tableView = UITableView()
    var places = [Place]()
    let persistenceManager: PersistenceManager
    
    init(persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retrievePlaces()
    }
    
    private func configure() {
        view.backgroundColor = .white
        title = "My Places"
        navigationController?.navigationBar.prefersLargeTitles = true
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlace))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func addPlace() {
        let destVC = NewPlaceViewController()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
        tableView.reloadData()
    }
    
    private func retrievePlaces() {
        let places = persistenceManager.fetch(Place.self)
        self.places = places
        tableView.reloadData()
    }
}

extension PlacesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.identifier, for: indexPath) as! PlaceCell
        cell.cellData = places[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let destVC = PlaceInfoViewController()
//    }
    
    
}

