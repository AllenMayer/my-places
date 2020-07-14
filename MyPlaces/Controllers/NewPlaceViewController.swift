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
    
    var retrievedLocation: MyLocation!
        
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
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "location")
        button.translatesAutoresizingMaskIntoConstraints = false
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
    private let daysTextField: MPTextField = {
        let textField = MPTextField(placeholder: "Days...")
        textField.keyboardType = .numberPad
        return textField
    }()
    private let priceTextField: MPTextField = {
        let textField = MPTextField(placeholder: "Price...")
        textField.keyboardType = .numberPad
        return textField
    }()
    private let locationTextField: MPTextField = {
        let textField = MPTextField(placeholder: "Location...")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let customBlueButton = MPColoredButton(color: .customBlue)
    let customPinkButton = MPColoredButton(color: .customPink)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createDismissKeyboardTapGesture()
        addObserverToView()
        configureNavigation()
        configureImageView()
        configureDaysView()
        configureCoordinates()
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func addObserverToView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150
        
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    
    private func configureNavigation() {
        title = "New Place"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlace))
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
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
            placeTextField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/15),
            
            countryTextField.topAnchor.constraint(equalTo: placeTextField.bottomAnchor, constant: 10),
            countryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countryTextField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/15),
            
            daysTextField.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 10),
            daysTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            daysTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            daysTextField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/15),
            
            priceTextField.topAnchor.constraint(equalTo: daysTextField.bottomAnchor, constant: 10),
            priceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            priceTextField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/15),
        ])
    }
    
    private func configureCoordinates() {
        view.addSubview(locationButton)
        view.addSubview(locationTextField)
        
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 20),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5, constant: -20),
            locationButton.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/15),
            
            locationTextField.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 5),
            locationTextField.topAnchor.constraint(equalTo: locationButton.topAnchor),
            locationTextField.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor),
            locationTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5, constant: -25)
            
        ])
        
        locationButton.addTarget(self, action: #selector(searchPlace), for: .touchUpInside)
    }
    
    private func configureColorPicker() {
        
    }
    
    @objc private func searchPlace() {
        let coordinatesVC = CoordinatesViewController()
        let destVC = UINavigationController(rootViewController: coordinatesVC)
        coordinatesVC.delegate = self
        present(destVC, animated: true)
    }
    
    @objc private func addPlace() {
//        if !placeTextField.text!.isEmpty && !countryTextField.text!.isEmpty && !daysTextField.text!.isEmpty && !priceTextField.text!.isEmpty && placeImageView.image != nil {
//            let newPlace = MyPlace(place: placeTextField.text!, country: countryTextField.text!, days: Int(daysTextField.text!)!, price: Int(priceTextField.text!)!, color: UIColor.customBlue, photo: placeImageView.image!, location: retrievedLocation)
//        }
        
    }

    @objc private func choosePhoto() {
        ImagePickerManager().pickImage(self) { (image) in
            self.centerButton.setImage(nil, for: .normal)
            self.placeImageView.image = image
        }
    }
}

extension NewPlaceViewController: CoordinatesViewControllerDelegate {
    func didChooseLocation(location: MyLocation) {
        retrievedLocation = location
        locationTextField.text = "\(retrievedLocation.locationName)"
        locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
    }
}
