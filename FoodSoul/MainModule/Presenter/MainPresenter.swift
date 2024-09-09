//
//  MainView.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import Foundation

protocol MainView: NSObjectProtocol {
    func finishLoading()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MenuViewController,
         networkService: NetworkFetchProtocol)
    
    var mainCellViewModels: MenuArray { get set }
    func getMenu()
}

final class MainPresenter: MainViewPresenterProtocol  {
    
    weak var mainView: MainView?
    private let networkService: NetworkFetchProtocol
    var mainCellViewModels = MenuArray()
    
    required init(view: MenuViewController, networkService: NetworkFetchProtocol) {
        self.mainView = view
        self.networkService = networkService
        getMenu()
    }
    
    func getMenu() {
        networkService.fetchData { [weak self] data, error in
            guard let self = self else { return }
            
            if error != nil {
                print("MainVC NetworkDataFetch error:\(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data else { return }
                self.mainCellViewModels = data
                mainView?.finishLoading()
            }
        }
    }
}
