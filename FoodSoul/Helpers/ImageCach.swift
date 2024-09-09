//
//  ImageCach.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private var cache = [URL: UIImage]()
    private let queue = DispatchQueue(label: "imageCacheQueue", qos: .default, attributes: .concurrent)
    
    func getImage(url: URL) -> UIImage? {
        var image: UIImage?
        queue.sync {
            image = cache[url]
        }
        return image
    }
    
    func cacheImage(url: URL, image: UIImage) {
        queue.async(flags: .barrier) {
            self.cache[url] = image
        }
    }
}
