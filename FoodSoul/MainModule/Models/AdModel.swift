//
//  AdModel.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import Foundation

struct AdModel: Codable {
    
    let imageURL: String
    let title: String
}

struct AdViewModel {
    static let adModel: [AdModel] =
    [AdModel(imageURL: "Реклама1", title: "Ролл или пицца в подарок!"),
     AdModel(imageURL: "Реклама2", title: "3-я пицца за ту же цену!"),
     AdModel(imageURL: "Реклама3", title: "Здесь могла быть ваша реклама!"),
     AdModel(imageURL: "Реклама4", title: "Здесь могла быть ваша реклама!"),
     AdModel(imageURL: "Реклама5", title: "Ешьте больше овощей!")]
}
