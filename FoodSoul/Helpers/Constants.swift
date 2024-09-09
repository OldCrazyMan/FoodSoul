//
//  Constants.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

enum Constants {
    
    struct Constants {
        static let sideMenuAvatarLeading: CGFloat = 3
        static let sideMenuAvatarWidthAnchor: CGFloat = 190
        static let sideMenuAvatarHeightAnchor: CGFloat = 350
        
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        static let isLandscape = UIDevice.current.orientation.isLandscape
        
        static let cellWidth: CGFloat = screenWidth / 2.02
        static let cellHeightPortrait: CGFloat = cellWidth * 1.6
        static let cellHeightLandscape: CGFloat = cellWidth / 1.5
        
        static let headerHeight: CGFloat = 290
    }
    
    struct Color {
        static let specialRed = #colorLiteral(red: 0.8274509804, green: 0.1882352941, blue: 0.1921568627, alpha: 1)
        static let specialOrange = #colorLiteral(red: 0.937254902, green: 0.6588235294, blue: 0.1058823529, alpha: 1)
        static let specialGray = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        static let specialWhite = #colorLiteral(red: 0.9750779271, green: 0.9750778079, blue: 0.9750779271, alpha: 1)
    }
    
    enum Images {
        static let spiderImage = UIImage(named: "SpiderImage")
        static let batmanImage = UIImage(named: "batmanImage")
        static let zamokImage = UIImage(named: "zamok")
        static let circleImage = UIImage(systemName: "x.circle.fill")
    }
}
