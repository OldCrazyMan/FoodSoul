//
//  URLString.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import Foundation

protocol NetworkFetchProtocol {
    func fetchData(responce: @escaping (MenuArray?, Error?) -> Void)
}

final class NetworkFetch: NetworkFetchProtocol {
    
    func fetchData(responce: @escaping (MenuArray?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData() { result in
            switch result {
            case .success(let data):
                do {
                    let pizza = try JSONDecoder().decode(MenuArray.self, from: data)
                    responce(pizza, nil)
                } catch {
                    print("Failed to decode JSON")
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
