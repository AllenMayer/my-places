//
//  CoordinatesViewController.swift
//  MyPlaces
//
//  Created by Максим Семений on 13.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CoordinatesViewController: UIViewController {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    let regionInMeters: Double = 10000
    
    var safeArea: UILayoutGuide!
    
    let pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pin")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        return imageView
    }()
    
    lazy var locationTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: view.frame.size.height / 40, weight: .semibold)
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureMapView()
        checkLocationServices()
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        view.addSubview(pinImageView)
        view.addSubview(locationTitle)
        
        safeArea = view.layoutMarginsGuide
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            pinImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinImageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -20),
            pinImageView.widthAnchor.constraint(equalToConstant: 40),
            pinImageView.heightAnchor.constraint(equalToConstant: 40),
            
            locationTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationTitle.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            locationTitle.heightAnchor.constraint(equalToConstant: view.frame.size.height / 10)
        ])
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    private func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension CoordinatesViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension CoordinatesViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        guard let previousLocation = self.previousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
                
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let _ = error { return }
            guard let placemark = placemarks?.first else { return }
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
                        
            DispatchQueue.main.async {
                self.locationTitle.text = "\(streetNumber) \(streetName)"
            }
        }
    }
}
