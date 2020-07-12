//
//  PlaceCell.swift
//  MyPlaces
//
//  Created by Максим Семений on 12.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    static let identifier = "PlaceCell"

    let placeInfoView = UIView()
    let placeImageView = UIImageView()
    
    
    // MARK: StackViews
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let locationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    let daysStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    let priceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    let daysAndPriceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    
    // MARK: Labels
    lazy var placeTitle = MPLabel(title: "Island Bali", size: frame.height / 1.5, weight: .bold)
    lazy var countryTitle = MPLabel(title: "Indonezia", size: 14, weight: .regular)
    lazy var daysTitle = MPLabel(title: "Days", size: 14, weight: .regular)
    lazy var numberOfDaysTitle = MPLabel(title: "7 Days", size: 16, weight: .medium)
    lazy var priceTitle = MPLabel(title: "Price", size: 14, weight: .regular)
    lazy var priceAmountTitle = MPLabel(title: "$1500", size: 16, weight: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBackgroundView()
        setupImageView()
        setupStackViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackViews() {
        addSubview(containerStackView)
        
        daysStackView.addArrangedSubview(daysTitle)
        daysStackView.addArrangedSubview(numberOfDaysTitle)

        priceStackView.addArrangedSubview(priceTitle)
        priceStackView.addArrangedSubview(priceAmountTitle)

        daysAndPriceStackView.addArrangedSubview(daysStackView)
        daysAndPriceStackView.addArrangedSubview(priceStackView)

        locationStackView.addArrangedSubview(placeTitle)
        locationStackView.addArrangedSubview(countryTitle)

        containerStackView.addArrangedSubview(locationStackView)
        containerStackView.addArrangedSubview(daysAndPriceStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: placeInfoView.leadingAnchor, constant: frame.size.width / 2.5),
            containerStackView.topAnchor.constraint(equalTo: placeInfoView.topAnchor, constant: 20),
            containerStackView.bottomAnchor.constraint(equalTo: placeInfoView.bottomAnchor, constant: -20),
            containerStackView.trailingAnchor.constraint(equalTo: placeInfoView.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupBackgroundView() {
        addSubview(placeInfoView)
        placeInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            placeInfoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            placeInfoView.heightAnchor.constraint(equalTo: heightAnchor, constant: -50),
            placeInfoView.widthAnchor.constraint(equalTo: widthAnchor, constant: -60)
        ])
        
        placeInfoView.backgroundColor = UIColor(red: 9/255, green: 163/255, blue: 237/255, alpha: 1)
        placeInfoView.layer.masksToBounds = true
        placeInfoView.layer.cornerRadius = 20
    }
    
    private func setupImageView() {
        addSubview(placeImageView)
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placeImageView.topAnchor.constraint(equalTo: topAnchor),
            placeImageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -30),
            placeImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2/5)
        ])
        
        placeImageView.layer.masksToBounds = true
        placeImageView.layer.cornerRadius = 20
        placeImageView.image = UIImage(named: "1")
        placeImageView.contentMode = .scaleToFill

    }
}
