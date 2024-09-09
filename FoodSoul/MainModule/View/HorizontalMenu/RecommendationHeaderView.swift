//
//  RecommendationHeaderView.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

final class RecommendationHeaderView: UICollectionReusableView {
    
    private let bannersView: BannersView = {
        let bannerView = BannersView()
        bannerView.backgroundColor = Constants.Color.specialRed
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        return bannerView
    }()
    
    private let recomendLabel = UILabel(text: "Мы рекомендуем",
                                     textColor: .black,
                                     font: UIFont.systemFont(ofSize: 19, weight: .bold),
                                     aligment: .left,
                                     line: 1)
    
    
    private let categoriesView = CategoriesView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(bannersView)
        addSubview(categoriesView)
        addSubview(recomendLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            bannersView.topAnchor.constraint(equalTo: topAnchor),
            bannersView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannersView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannersView.bottomAnchor.constraint(equalTo: categoriesView.topAnchor),
            
            categoriesView.topAnchor.constraint(equalTo: bannersView.bottomAnchor),
            categoriesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesView.heightAnchor.constraint(equalToConstant: 75),
            
            recomendLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            recomendLabel.topAnchor.constraint(equalTo: categoriesView.bottomAnchor, constant: 8),
            recomendLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }
}
