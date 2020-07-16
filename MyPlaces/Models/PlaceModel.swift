//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Максим Семений on 13.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit
import CoreLocation

struct MyPlace {
    let place: String
    let country: String
    let days: Int
    let price: Int
    let color: UIColor
    let photo: UIImage
    let location: MyLocation
}

struct MyLocation {
    var locationName: String
    var latitude: Double
    var longitude: Double
}
