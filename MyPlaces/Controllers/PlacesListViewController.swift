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
    let cat = ["Cat", "Cat"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
    }
    
    private func configure() {
        view.backgroundColor = .white
        title = "My Places"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        return cat.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.identifier, for: indexPath) as! PlaceCell
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    
}

