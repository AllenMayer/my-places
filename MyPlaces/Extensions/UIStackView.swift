//
//  UIStackView.swift
//  MyPlaces
//
//  Created by Максим Семений on 15.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
