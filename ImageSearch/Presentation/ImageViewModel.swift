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
    
    private let imageRepository: ImageRepository
    private let bookmarkRepository: BookmarkRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(imageRepository: ImageRepository, bookmarkRepository: BookmarkRepository) {
        self.imageRepository = imageRepository
        self.bookmarkRepository = bookmarkRepository
        bindSubject()
    }
    
    private func bindSubject() {
        bookmarkRepository.bookmarkDidChange
            .sink { [weak self] imageUrl in
                self?.updateBookmarkStatus(for: imageUrl)
            }
            .store(in: &cancellables)
    }
    
    func search(_ query: String) {
        guard !query.isEmpty else { return }
        
        isLoading = true
        imageList.removeAll()
        
        Task {
            do {
                let images = try await imageRepository.searchImages(query: query, sortType: .recency)
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
        guard imageRepository.canLoadMore(), !isLoading else { return }
        
        isLoading = true
        Task {
            do {
                let moreImages = try await imageRepository.loadMore()
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
        return imageRepository.canLoadMore()
    }
    
    private func updateBookmarkStatus(for imageUrl: String) {
        guard let index = imageList.firstIndex(where: { $0.imageUrl == imageUrl }) else {
            return
        }
        
        var updatedImage = imageList[index]
        updatedImage.isBookmark = bookmarkRepository.isBookmark(updatedImage)
        
        var updatedList = imageList
        updatedList[index] = updatedImage
        imageList = updatedList
    }
    
}



extension ImageViewModel: BookmarkController {
    func toggleBookmark(_ image: ImageData) {
        bookmarkRepository.toggleBookmark(image)
    }
}
