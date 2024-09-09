//
//  MainView.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import Foundation

struct MenuModel: Codable {   
    
        let imageURL: String?
        let title, description: String?
        let price, weight: Int?
        let hit, new: Bool

        enum CodingKeys: String, CodingKey {
         
            case imageURL = "imageUrl"
            case title, description, price, weight, hit, new
        }
}

typealias MenuArray = [MenuModel]
