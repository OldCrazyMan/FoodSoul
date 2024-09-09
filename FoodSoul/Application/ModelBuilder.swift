//
//  ModelBuilder.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModelBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let view = MenuViewController()
        let networkService = NetworkFetch()
        let presenter = MainPresenter(view: view, networkService: networkService)
        
        view.presenter = presenter
        return view
    }
}
