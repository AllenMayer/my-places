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
    
    var retrievedLocation: MyLocation?
    
    let persistenceManager = PersistenceManager.shared
            
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
        button.backgroundColor = buttons.first!.backgroundColor
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
    let customOrangeButton = MPColoredButton(color: .customOrange)
    let customRedButton = MPColoredButton(color: .customRed)
    let customTurquoiseButton = MPColoredButton(color: .customTurquoise)
    lazy var buttons = [customRedButton, customBlueButton, customPinkButton, customOrangeButton, customTurquoiseButton]
    
    let coloredButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createDismissKeyboardTapGesture()
        addObserverToView()
        configureNavigation()
        configureImageView()
        configureDaysView()
        configureCoordinates()
        configureColoredButtons()
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
        view.addSubviews(placeTextField, countryTextField, daysTextField, priceTextField)

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
        view.addSubviews(locationButton, locationTextField)
        
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
    
    private func configureColoredButtons() {
        view.addSubview(coloredButtonsStackView)
        coloredButtonsStackView.addArrangedSubviews(customRedButton, customBlueButton, customPinkButton, customOrangeButton, customTurquoiseButton)
        
        NSLayoutConstraint.activate([
            coloredButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            coloredButtonsStackView.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 40),
            coloredButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            coloredButtonsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        buttons.first!.setImage(UIImage(systemName: "checkmark"), for: .normal)
        
        for button in buttons {
            button.addTarget(self, action: #selector(coloredButtonSelected(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func coloredButtonSelected(_ sender: UIButton) {
        for button in buttons {
            button.setImage(nil, for: .normal)
        }
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.20, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            sender.transform = CGAffineTransform.identity
        })
        sender.setImage(UIImage(systemName: "checkmark"), for: .normal)
        locationButton.backgroundColor = sender.backgroundColor
    }
    
    @objc private func searchPlace() {
        let coordinatesVC = CoordinatesViewController()
        let destVC = UINavigationController(rootViewController: coordinatesVC)
        coordinatesVC.delegate = self
        if retrievedLocation != nil {
            coordinatesVC.delegatedLocation = MyLocation(locationName: retrievedLocation!.locationName, latitude: retrievedLocation!.latitude, longitude: retrievedLocation!.longitude)
        }
        present(destVC, animated: true)
    }
    
    @objc private func addPlace() {
        if !placeTextField.text!.isEmpty && !countryTextField.text!.isEmpty && !daysTextField.text!.isEmpty && !priceTextField.text!.isEmpty && placeImageView.image != nil && retrievedLocation != nil {
            
            let color = locationButton.backgroundColor
            let colorData = color!.encode()
            let imageData = placeImageView.image!.jpegData(compressionQuality: 1.0)
            
            let location = Location(context: persistenceManager.context)
            location.latitude = retrievedLocation!.latitude
            location.longitude = retrievedLocation!.longitude
            location.locationName = retrievedLocation!.locationName
            
            let place = Place(context: persistenceManager.context)
            place.place = placeTextField.text!
            place.country = countryTextField.text!
            place.days = Int16(daysTextField.text!)!
            place.price = Int16(priceTextField.text!)!
            place.photo = imageData
            place.color = colorData
            place.location = location
            
            persistenceManager.save()
            
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        
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
        locationTextField.text = "\(retrievedLocation!.locationName)"
        locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
    }
}
