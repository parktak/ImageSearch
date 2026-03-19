//
//  ImageLoader.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/18/26.
//

import Foundation
import UIKit
import Combine

class ImageLoader: ObservableObject {
    let imageCacher: ImageCacheManager
    @Published var image: UIImage?
    @Published var isLoading = false
    
    init(imageCacher: ImageCacheManager) {
        self.imageCacher = imageCacher
    }
    
    func fetchImage(_ url: String) {
        Task {
            guard !isLoading else { return }
            isLoading = true
            
            
            if let image = imageCacher.getImage(url) {
#if DEBUG
                print("get an image from cahce")
#endif
                await MainActor.run {
                    isLoading = false
                    self.image = image
                }
                return
            }
            
            let image = await loadImage(from: url)
            
            if let image {
#if DEBUG
                print("get an image from URL")
#endif
                imageCacher.cacheImage(url, image: image)
            }
            
            await MainActor.run {
                isLoading = false
                self.image = image
            }
        }
    }
    
    private func loadImage(from url: String) async -> UIImage? {
        
        guard let url = URL(string: url) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
            
        } catch {
#if DEBUG
            print("Failed to load image: \(error.localizedDescription)")
#endif
            return nil
        }
    }
}
