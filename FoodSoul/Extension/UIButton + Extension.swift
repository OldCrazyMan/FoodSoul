//
//  UIButton + Extension.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

extension UIButton {
    convenience init(color: UIColor, image: String) {
        self.init()
        
        let image = UIImage(named: image)!
        let coloredImage = image.withRenderingMode(.alwaysTemplate)
        self.setImage(coloredImage, for: .normal)
        
        self.titleLabel?.textColor = .black
        self.tintColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
