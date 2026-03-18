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
    @Published private(set) var isLoading = false
    
    private let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func search(_ query: String) {
        guard !query.isEmpty else { return }
        
        isLoading = true
        imageList.removeAll()
        
        
        Task {
            do {
                let images = try await repository.searchImages(query: query, sortType: .recency)
                await MainActor.run {
                    self.imageList = images
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
                // 에러처리 토스트?
            }
        }
    }
    
    func loadMore() {
        guard repository.canLoadMore(), !isLoading else { return }
        
        isLoading = true
        Task {
            do {
                let moreImages = try await repository.loadMore()
                await MainActor.run {
                    self.imageList.append(contentsOf: moreImages)
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
                // 에러처리 토스트?
            }
        }
    }
    
    var canLoadMore: Bool {
        return repository.canLoadMore()
    }
    
    func toggleBookmark(_ image: ImageData) {
        repository.toggleBookmark(image)
        
        if let index = imageList.firstIndex(where: { $0.imageUrl == image.imageUrl }) {
            imageList[index].isBookmark.toggle()
        }
    }
    
    func isBookmarked(_ image: ImageData) -> Bool {
        return repository.isBookmark(image)
    }
    
}

