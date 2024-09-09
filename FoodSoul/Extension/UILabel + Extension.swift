//
//  UILabel + Extension.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, textColor: UIColor, font: UIFont, aligment: NSTextAlignment, line: Int) {
        
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = line
        
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = aligment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
   
    convenience init(text: String, textColor: UIColor, font: UIFont, aligment: NSTextAlignment, line: Int, radius: CGFloat)  {
        
        self.init()
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = line
        
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = aligment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
