//
//  SceneDelegate.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit


final class BannersView: UIView {
    
    private let collectionView = UICollectionView(minimumLineSpacing: 0,
                                                  scrollDirection: .horizontal,
                                                  backgroundColor: .clear,
                                                  bounces: false)
    
    private let adArray = AdViewModel.adModel
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupCollectionView()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = Constants.Color.specialRed
        addSubview(collectionView)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseId)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionView

extension BannersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        adArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseId, for: indexPath) as? BannerCell else { return UICollectionViewCell() }
        
        let model = adArray[indexPath.row]
        cell.cellConfigure(with: model)
        return cell
    }
}

extension BannersView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        if isLandscape {
            return CGSize(width: collectionView.bounds.width / 2,
                          height: collectionView.bounds.height)
        } else {
            return CGSize(width: collectionView.bounds.width * 0.8,
                          height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
}
