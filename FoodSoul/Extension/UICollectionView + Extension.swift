//
//  UICollectionView + Extension.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 09.09.2024.
//

import UIKit

extension UICollectionView {
    
    convenience init(minimumLineSpacing: CGFloat = 0, minimumInteritemSpacing: CGFloat = 0, scrollDirection: UICollectionView.ScrollDirection = .vertical, backgroundColor: UIColor = .clear, bounces: Bool = true) {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.scrollDirection = scrollDirection
        
        self.init(frame: .zero, collectionViewLayout: layout)
        
        self.backgroundColor = backgroundColor
        self.bounces = bounces
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

