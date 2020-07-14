//
//  MPColoredButton.swift
//  MyPlaces
//
//  Created by Максим Семений on 14.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

class MPColoredButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        configure(with: color)
    }
    
    private func configure(with color: UIColor) {
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
