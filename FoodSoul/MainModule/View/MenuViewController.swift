//
//  SceneDelegate.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit
import FBSDKCoreKit

protocol MainTabBarControllerDelegate: AnyObject {
    func didTapButtonMenu()
}

final class MenuViewController: UIViewController {
    
    private let collectionView = UICollectionView(minimumLineSpacing: 1,
                                                  minimumInteritemSpacing: 3,
                                                  scrollDirection: .vertical,
                                                  backgroundColor: Constants.Color.specialWhite,
                                                  bounces: false)
    
    var presenter: MainViewPresenterProtocol!
    weak var protocolDelegate: MainTabBarControllerDelegate?
    
    private var isFiltered = false
    private var filteredData = MenuArray()
    private var searchBar: UISearchBar!
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    private let deliveryView = DeliveryView()
    
    // MARK: - Lifecycle
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        setConstraints()
        setupNavigationBar()
        setupFacebookSDK()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = Constants.Color.specialRed
        
        view.addSubview(deliveryView)
        view.addSubview(collectionView)
    }
    
    private func setupNavigationBar() {
        title = "Meню"
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "threeLinesIcon"), 
                                                style: .plain,
                                                target: self,
                                                action: #selector(openSideMenu))
        let infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(showInfo))
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(showSearchBar))
        
        leftBarButtonItem.tintColor = Constants.Color.specialWhite
        infoBarButtonItem.tintColor = Constants.Color.specialWhite
        searchBarButtonItem.tintColor = Constants.Color.specialWhite
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItems = [searchBarButtonItem, infoBarButtonItem]
        
        setupSearchBar()
    }
    
    // MARK: - Настройка Facebook SDK
    private func setupFacebookSDK() {
        Settings.shared.isAdvertiserIDCollectionEnabled = true
    }
    
    // MARK: - Setup SearchBar
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
        searchBar.barTintColor = Constants.Color.specialWhite
        searchBar.backgroundColor = Constants.Color.specialRed
        searchBar.barStyle = .default
        searchBar.isTranslucent = false
    }
    
    private func addTaps() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureRecognizer?.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer!)
    }

    private func removeTaps() {
        if let tapGestureRecognizer = tapGestureRecognizer {
            view.removeGestureRecognizer(tapGestureRecognizer)
            self.tapGestureRecognizer = nil
        }
    }
    
    // MARK: - Actions
    
    @objc private func hideKeyboard() {
        print("hideKeyboard вызван")
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
    
    @objc private func openSideMenu() {
        print("openSideMenu")
        protocolDelegate?.didTapButtonMenu()
    }
    
    @objc private func showInfo() {
        // Событие для клика на поиск
        AppEvents.shared.logEvent(AppEvents.Name(rawValue: "showInfo"), parameters: [AppEvents.ParameterName.init("Key"):"Value"])
        
        print("Info button tapped")
    }
    
    @objc private func showSearchBar() {
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.titleView = self.navigationItem.titleView == self.searchBar ? nil : self.searchBar
        }
        
        // Событие для клика на поиск
        AppEvents.shared.logEvent(AppEvents.Name(rawValue: "ShowSearchBar"), parameters: [AppEvents.ParameterName(rawValue: "Key"): "Value"])
        
        print("Search bar opened")
    }
    
    //    @objc private func showSearchBar() {
    //        if navigationItem.titleView == searchBar {
    //            UIView.animate(withDuration: 0.2) {
    //                self.searchBar.alpha = 0
    //            } completion: { _ in
    //                self.navigationItem.titleView = nil
    //            }
    //        } else {
    //            searchBar.alpha = 0
    //            navigationItem.titleView = searchBar
    //            UIView.animate(withDuration: 0.2) {
    //                self.searchBar.alpha = 1
    //            }
    //        }
    //        print("Search bar opened")
    //    }
    
    // MARK: - Setup CollectionView
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RecommendationHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "recommendationHeader")
        collectionView.register(MenuCollectionViewCell.self,
                                forCellWithReuseIdentifier: MenuCollectionViewCell.collectionViewCellId)
    }
 
    // MARK: - Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            deliveryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            deliveryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deliveryView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            collectionView.topAnchor.constraint(equalTo: deliveryView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - Filtering
    
    private func filterData(by text: String) {
        if text.isEmpty {
            isFiltered = false
            filteredData = presenter.mainCellViewModels
        } else {
            isFiltered = true
            filteredData = presenter.mainCellViewModels.filter { $0.title?.lowercased().contains(text.lowercased()) ?? false }
        }
        collectionView.reloadData()
    }
}

// MARK: - Presenter

extension MenuViewController: MainView {
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


// MARK: - UICollectionView

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltered ? filteredData.count : presenter.mainCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.collectionViewCellId, for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        
        let model = isFiltered ? filteredData[indexPath.row] : presenter.mainCellViewModels[indexPath.row]
        cell.configureCell(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "recommendationHeader", for: indexPath) as? RecommendationHeaderView else { return UICollectionReusableView() }
                return headerView
            } else {
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        let cellWidth: CGFloat
        let cellHeight: CGFloat
        
        if isLandscape {
            cellWidth = screenWidth / 4
            cellHeight = cellWidth * 1.5
        } else {
            cellWidth = screenWidth / 2.02
            cellHeight = cellWidth * 1.6
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.Constants.headerHeight)
    }
}

// MARK: - UISearchBarDelegate

extension MenuViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filterData(by: searchText)
        }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           addTaps()
       }

       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           removeTaps()
       }
}
