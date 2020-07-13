//
//  CoordinatesViewController.swift
//  MyPlaces
//
//  Created by Максим Семений on 13.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit
import MapKit

class CoordinatesViewController: UIViewController {
    
    let mapView = MKMapView()
    var safeArea: UILayoutGuide!
    let pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "mappin")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        view.addSubview(pinImageView)
        
        safeArea = view.layoutMarginsGuide
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pinImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinImageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -20),
            pinImageView.widthAnchor.constraint(equalToConstant: 40),
            pinImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
