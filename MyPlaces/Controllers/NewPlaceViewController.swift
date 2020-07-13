//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Максим Семений on 13.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

final class NewPlaceViewController: UIViewController {
    
    private var safeArea: UILayoutGuide!
    private let imagePicker = UIImagePickerController()
        
    private let placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let centerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "photo.on.rectangle"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let coordinatesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Locate", for: .normal)
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.backgroundColor = .link
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let placeTextField = MPTextField(placeholder: "Place...")
    private let countryTextField = MPTextField(placeholder: "Country...")
    private let daysTextField = MPTextField(placeholder: "Days...")
    private let priceTextField = MPTextField(placeholder: "Price...")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigation()
        configureImageView()
        configureDaysView()
        configureCoordinates()
    }
    
    private func configureNavigation() {
        title = "New Place"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlace))
    }
    
    private func configureImageView() {
        view.addSubview(placeImageView)
        safeArea = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            placeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            placeImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4)
        ])
        
        view.addSubview(centerButton)
        
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: placeImageView.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: placeImageView.centerYAnchor),
            centerButton.heightAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 4/5),
            centerButton.widthAnchor.constraint(equalTo: placeImageView.heightAnchor),
        ])
        
        centerButton.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
    }
    
    private func configureDaysView() {
        view.addSubview(placeTextField)
        view.addSubview(countryTextField)
        view.addSubview(daysTextField)
        view.addSubview(priceTextField)

        NSLayoutConstraint.activate([
            placeTextField.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 30),
            placeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            placeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            placeTextField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/12),
            
            countryTextField.topAnchor.constraint(equalTo: placeTextField.bottomAnchor, constant: 10),
            countryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countryTextField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/12),
            
            daysTextField.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 10),
            daysTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            daysTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            daysTextField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/12),
            
            priceTextField.topAnchor.constraint(equalTo: daysTextField.bottomAnchor, constant: 10),
            priceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            priceTextField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/12),
        ])
    }
    
    private func configureCoordinates() {
        view.addSubview(coordinatesButton)
        
        NSLayoutConstraint.activate([
            coordinatesButton.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 20),
            coordinatesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            coordinatesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            coordinatesButton.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/15)
        ])
        
        coordinatesButton.addTarget(self, action: #selector(searchPlace), for: .touchUpInside)
    }
    
    @objc private func searchPlace() {
        let destVC = UINavigationController(rootViewController: CoordinatesViewController())
        present(destVC, animated: true)
    }
    
    @objc private func addPlace() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func choosePhoto() {
        print("Tap!")
        
        ImagePickerManager().pickImage(self) { (image) in
            self.centerButton.setImage(nil, for: .normal)
            self.placeImageView.image = image
        }
    }
}
