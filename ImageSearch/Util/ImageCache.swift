//
//  ImageCache.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/18/26.
//

import Foundation
import UIKit

class ImageCacheManager {
    
    private var caches = NSCache<NSString, UIImage>()
    
    init() {
        caches.countLimit = 100
    }
    
    func getImage(_ url: String) -> UIImage? {
        caches.object(forKey: url as NSString)
    }
    
    func cacheImage(_ url: String, image: UIImage) {
        if caches.object(forKey: url as NSString) != nil {
            return
        }
        
        caches.setObject(image, forKey: url as NSString)
    }
    
    private func removeImage(_ url: String) {
        caches.removeObject(forKey: url as NSString)
    }
}
