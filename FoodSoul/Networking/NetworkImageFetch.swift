//
//  URLString.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import Foundation

final class NetworkImageFetch {
    
    static let shared = NetworkImageFetch()
    private init() {}
    
    func requestImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkImageFetch", code: 0, userInfo: [NSLocalizedDescriptionKey: "Данные не найдены"])))
                return
            }
            completion(.success(data))
        }
        .resume()
    }
}
