//
//  DeliveryView.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

final class DeliveryView: UIView {
    
    private let segmentedControl: CustomSegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: ["Доставка", "Самовывоз"])
        segmentedControl.selectedSegmentIndex = 0
        
        let font = UIFont.boldSystemFont(ofSize: 12)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                 NSAttributedString.Key.foregroundColor: UIColor.white],
                                                for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                 NSAttributedString.Key.foregroundColor: UIColor.white],
                                                for: .selected)
        
        let redImage = UIImage(color: Constants.Color.specialRed,
                               size: CGSize(width: 10, height: 10))
        let whiteImage = UIImage(color: .white,
                                 size: CGSize(width: 10, height: 10))
        
        segmentedControl.setBackgroundImage(redImage,
                                            for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(whiteImage,
                                            for: .normal, barMetrics: .default)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("   Укажите адрес доставки", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.tintColor = .black
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let arrowImageView: UIImageView = {
        let arrow = UIImageView(image: UIImage(systemName: "chevron.compact.right"))
        arrow.tintColor = .black
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setConstraints()
        setTargets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
        setConstraints()
    }
    
    // Setup UI
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white.withAlphaComponent(0.43)
        
        addSubview(segmentedControl)
        addSubview(button)
        button.addSubview(arrowImageView)
        
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    // MARK: - Targets
    
    private func setTargets() {
        segmentedControl.addTarget(self,
                                   action: #selector(handleSegmentChange),
                                   for: .valueChanged)
        button.addTarget(self,
                         action: #selector(handleButtonTap),
                         for: .touchUpInside)
    }
    
    // MARK: - Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35),
            
            button.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 35),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            arrowImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            arrowImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 10),
            arrowImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    // MARK: - Actions
    
    @objc func handleSegmentChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            button.setTitle("   Укажите адрес доставки", for: .normal)
        case 1:
            button.setTitle("   Укажите адрес самовывоза", for: .normal)
        default:
            break
        }
    }
    
    @objc func handleButtonTap() {
        print("Button tapped")
    }
}
