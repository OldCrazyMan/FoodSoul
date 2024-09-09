
//
//  MenuCollectionViewCell.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let cellBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.specialWhite
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "testImage"))
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel = UILabel(text: "Название",
                                     textColor: .black,
                                     font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                     aligment: .left,
                                     line: 3)
      
    private let newLabel = UILabel(text: " НОВИНКА 🥳",
                                   textColor: Constants.Color.specialWhite,
                                   font: UIFont.boldSystemFont(ofSize: 10),
                                   aligment: .center,
                                   line: 1,
                                   radius: 6.0)
    
    private let hitLabel = UILabel(text: " ХИТ 🤩",
                                   textColor: Constants.Color.specialWhite,
                                   font: UIFont.boldSystemFont(ofSize: 10),
                                   aligment: .left,
                                   line: 1,
                                   radius: 6.0)
    
    private let descriptionLabel = UILabel(text: " ",
                                     textColor: .black,
                                     font: UIFont.systemFont(ofSize: 10),
                                     aligment: .left,
                                     line: 7)
    
    private let weightLabel = UILabel(text: " ",
                                     textColor: .black,
                                     font: UIFont.boldSystemFont(ofSize: 12),
                                     aligment: .left,
                                     line: 7)
    
    private let priceLabel = UILabel(text: " ",
                                     textColor: Constants.Color.specialRed,
                                     font: UIFont.boldSystemFont(ofSize: 16),
                                     aligment: .left,
                                     line: 7)

    private let heartButton = UIButton(color: Constants.Color.specialWhite,
                                       image: "heartButton.png")
    
    private let plusButton = UIButton(color: Constants.Color.specialRed,
                                       image: "plusButton.png")
    
    static let collectionViewCellId = "MenuCollectionViewCell"

    private let padding: CGFloat = 8
    private let cornerRadius: CGFloat = 10
    
    private var isHitHidden = true
    private var isNewHidden = true
    private var isHeartButtonSelected = false
    
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = UIImage(named: "testImage")
        hitLabel.isHidden = isHitHidden
        newLabel.isHidden = isNewHidden
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setTargets()
        setConstraints()
    }
    
    // MARK: - Setup
    
    private func setupCell() {         
        
        addShadow()
        heartButton.addShadow()
        hitLabel.backgroundColor = Constants.Color.specialOrange
        newLabel.backgroundColor = Constants.Color.specialRed
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(cellBackground)
        contentView.addSubview(cellImageView)
        contentView.addSubview(hitLabel)
        contentView.addSubview(newLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(weightLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(heartButton)
        contentView.addSubview(plusButton)
    }
    
    // MARK: - Targets
    
    private func setTargets() {
        heartButton.addTarget(self, 
                              action: #selector(toggleHeartButton),
                              for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(incrementCount),
                             for: .touchUpInside)
    }
    
    // MARK: - Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cellBackground.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            cellBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cellBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cellBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cellImageView.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: padding),
            cellImageView.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: padding),
            cellImageView.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -padding),
            cellImageView.heightAnchor.constraint(equalToConstant: frame.width / 1.5),
            
            hitLabel.topAnchor.constraint(equalTo: cellImageView.topAnchor, constant: 15),
            hitLabel.leadingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: padding),
            hitLabel.heightAnchor.constraint(equalToConstant: 15),
            
            newLabel.topAnchor.constraint(equalTo: hitLabel.bottomAnchor, constant: 5),
            newLabel.leadingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: padding),
            newLabel.heightAnchor.constraint(equalToConstant: 15),
            
            heartButton.centerYAnchor.constraint(equalTo: hitLabel.centerYAnchor),
            heartButton.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -padding),
            heartButton.widthAnchor.constraint(equalToConstant: 28),
            heartButton.heightAnchor.constraint(equalToConstant: 28),
            
            titleLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -padding),
            
            weightLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            weightLabel.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: padding),
            weightLabel.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -padding),
            
            plusButton.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -padding),
            plusButton.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -padding),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            
            priceLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -padding),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func toggleHeartButton() {
        isHeartButtonSelected.toggle()      
        heartButton.tintColor = isHeartButtonSelected ? .red : .white
    }
    
    @objc private func incrementCount() {
        print("+")
    }
    
    // MARK: - Configuration

    private func getImage(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                ImageCache.shared.cacheImage(url: url, image: image)
                DispatchQueue.main.async {
                    self.cellImageView.image = image
                }
            } else {
                print("Ошибка создания изображения")
            }
        }.resume()
    }
    
    public func configureCell(with model: MenuModel) {
        hitLabel.isHidden = !model.hit
        newLabel.isHidden = !model.new
        
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        weightLabel.text = "\(model.weight ?? 0) г."
        priceLabel.text = "\(model.price ?? 0) р."
       
        let urlString = model.imageURL ?? "no-image-found"
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = ImageCache.shared.getImage(url: url) {
            cellImageView.image = cachedImage
        } else {
            getImage(url: url)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
