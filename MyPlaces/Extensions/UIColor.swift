//
//  UIColor.swift
//  MyPlaces
//
//  Created by Максим Семений on 13.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let customTurquoise = UIColor(red: 43/255, green: 178/255, blue: 187/255, alpha: 1)
    static let customBlue = UIColor(red: 139/255, green: 205/255, blue: 205/255, alpha: 1)
    static let customOrange = UIColor(red: 242/255, green: 170/255, blue: 170/255, alpha: 1)
    static let customPink = UIColor(red: 255/255, green: 114/255, blue: 104/255, alpha: 1)
    static let customRed = UIColor(red: 227/255, green: 99/255, blue: 135/255, alpha: 1)
    
    class func color(data: Data) -> UIColor? {
         return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }

    func encode() -> Data? {
         return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}
