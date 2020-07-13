//
//  PlacesListViewController.swift
//  MyPlaces
//
//  Created by Максим Семений on 12.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

final class PlacesListViewController: UIViewController {
    
    let tableView = UITableView()
    let places: [Place] = [
        Place(place: "Island Bali", country: "Indonezia", days: 7, price: 1500, color: UIColor.customBlue, photo: UIImage(named: "1")!),
        Place(place: "Kyiv", country: "Ukraine", days: 10, price: 1000, color: UIColor.customPink, photo: UIImage(named: "2")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
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

