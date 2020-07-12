//
//  MPLabel.swift
//  MyPlaces
//
//  Created by Максим Семений on 12.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

class MPLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, size: CGFloat, weight: UIFont.Weight) {
        self.init(frame: .zero)
        self.text = title
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
