//
//  SceneDelegate.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit


final class CategoriesView: UIView {
    
    private let collectionView = UICollectionView(minimumInteritemSpacing: 10,
                                                  scrollDirection: .horizontal,
                                                  backgroundColor: .clear)
        
    private var categories = ["Популярное", 
                              "Японская кухня",
                              "Японская табуретка",
                              "Калининградские печенюшки"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupCollectionView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = Constants.Color.specialRed
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
    }
    
    private func setupCollectionView() {
           collectionView.dataSource = self
           collectionView.delegate = self
           collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
       }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UITableView

extension CategoriesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
       
        let title = categories[indexPath.row]
        
        cell.cellConfigure(with: title)
        return cell
    }
}

extension CategoriesView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let title = categories[indexPath.row]
            let font = UIFont.systemFont(ofSize: 16)
            let attributes = [NSAttributedString.Key.font: font]
            let estimatedWidth = title.size(withAttributes: attributes).width + 25
            let estimatedHeight = title.size(withAttributes: attributes).height + 15
        
            return CGSize(width: estimatedWidth,
                          height: estimatedHeight)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, 
                                  animated: true,
                                  scrollPosition: .centeredHorizontally)
    }
}
