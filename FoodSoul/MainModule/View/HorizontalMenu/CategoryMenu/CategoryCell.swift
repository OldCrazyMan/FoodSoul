//
//  SceneDelegate.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    private let titleLabel = UILabel(text: " ",
                                     textColor: .black,
                                     font: UIFont.boldSystemFont(ofSize: 14),
                                     aligment: .center,
                                     line: 7)
        
    private let cornerRadius: CGFloat = 16
    private let padding: CGFloat = 16
    
    static let reuseId = "CategoryCell"
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? Constants.Color.specialRed : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = Constants.Color.specialWhite
        
        layer.cornerRadius = cornerRadius
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    public func cellConfigure(with title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
