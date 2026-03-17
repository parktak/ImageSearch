//
//  ImageViewModel.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation
import Combine

class ImageViewModel: ObservableObject {
    @Published private(set) var imageList = [ImageData]()
    
    private let repository: ImageRepository
    private var isEnded = false
    private var query = ""
    private var currentPage = 1
    private let ImageDataSize = 5
    
    init(repository: ImageRepository) {
        self.repository = repository
//        search("설현")
    }
    
    func search(_ query: String) {
        
        self.imageList.removeAll()
        
        guard !query.isEmpty else { return }
        
        self.query = query
        self.isEnded = false
        
        requestImage(query: query, page: 1)
    }
    
    func loadMore() {
        requestImage(query: self.query, page: currentPage + 1)
    }
    
    func toggleBookmark(_ image: ImageData) {
        repository.toggleBookmark(image)
    }
    
    func isBookmarked(_ image: ImageData) -> Bool {
        return repository.isBookmark(image)
    }
    
    private func requestImage(query: String, page: Int) {
        self.currentPage = page
        
        Task {
            do {
                let result = try await repository.searchImages(query: query, sortType: .recency, size: ImageDataSize, page: page)
                self.isEnded = result.meta.isEnd
                
                await MainActor.run {
                    self.appendImageData(result.documents)
                }
            } catch {
                // 에러처리 토스트?
            }
        }
    }
    
    private func appendImageData(_ list: [ImageData]) {
        self.imageList.append(contentsOf: list)
    }
}

