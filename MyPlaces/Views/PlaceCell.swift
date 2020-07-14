//
//  PlaceCell.swift
//  MyPlaces
//
//  Created by Максим Семений on 12.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit
import MapKit

final class PlaceCell: UITableViewCell {
    
    static let identifier = "PlaceCell"
    
    var cellData: MyPlace! {
        didSet {
            placeTitle.text = cellData.place
            countryTitle.text = cellData.country
            numberOfDaysTitle.text = cellData.days == 1 ? "\(cellData.days) Day" : "\(cellData.days) Days"
            priceAmountTitle.text = "$\(cellData.price)"
            placeInfoView.backgroundColor = cellData.color
            placeImageView.image = cellData.photo
        }
    }

    private let placeInfoView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    // MARK: StackViews
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let locationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private let daysStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private let priceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private let daysAndPriceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    
    // MARK: Labels
    private lazy var placeTitle = MPLabel(title: "", size: frame.height / 1.5, weight: .bold)
    private lazy var countryTitle = MPLabel(title: "", size: frame.height / 3, weight: .regular)
    private lazy var daysTitle = MPLabel(title: "Days", size: frame.height / 3, weight: .regular)
    private lazy var numberOfDaysTitle = MPLabel(title: "", size: frame.height / 2.5, weight: .medium)
    private lazy var priceTitle = MPLabel(title: "Price", size: frame.height / 3, weight: .regular)
    private lazy var priceAmountTitle = MPLabel(title: "", size: frame.height / 2.5, weight: .medium)
    
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
            containerStackView.leadingAnchor.constraint(equalTo: placeInfoView.leadingAnchor, constant: frame.size.width / 2.3),
            containerStackView.topAnchor.constraint(equalTo: placeInfoView.topAnchor, constant: 20),
            containerStackView.bottomAnchor.constraint(equalTo: placeInfoView.bottomAnchor, constant: -20),
            containerStackView.trailingAnchor.constraint(equalTo: placeInfoView.trailingAnchor, constant: -50)
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
    }
    
    private func setupImageView() {
        addSubview(placeImageView)
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            placeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 4/5),
            placeImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2/5)
        ])
    }
}
