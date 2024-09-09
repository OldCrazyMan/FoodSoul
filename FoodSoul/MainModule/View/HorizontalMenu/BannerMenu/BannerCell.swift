//
//  BannerCell.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

final class BannerCell: UICollectionViewCell {
     
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Реклама1")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let adLabel = UILabel(text: "",
                                     textColor: Constants.Color.specialWhite,
                                     font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                     aligment: .left,
                                     line: 1)
    
    static let reuseId = "BannersView"
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(imageView)
        addSubview(adLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            imageView.heightAnchor.constraint(equalToConstant: frame.height - 38),
            
            adLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
            adLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            adLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3)
        ])
    }
    
    public func cellConfigure(with model: AdModel) {
        adLabel.text = model.title.uppercased()
        imageView.image = UIImage(named: "\(model.imageURL)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
