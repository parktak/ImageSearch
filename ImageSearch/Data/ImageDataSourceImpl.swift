//
//  ImageDataSourceImpl.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation
import Combine

class ImageDataSourceImpl: ImageDataSource {
    let apiClient: APIClient
    
    private let bookmarkDidChangeSubject = PassthroughSubject<String, Never>()
    
    var bookmarkDidChange: AnyPublisher<String, Never> {
        return bookmarkDidChangeSubject.eraseToAnyPublisher()
    }
    
    private var searchImages = [ImageData]()
    private var bookmarkImages = [String: ImageData]()
    
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func searchImages(query: String, sortType: ImageSortType, size: Int, page: Int) async throws -> ImageSearchResponse {
        let result = try await apiClient.getImageList(query, sortType: sortType, size: size, page: page)
        
        let imagesWithBookmarkStatus = result.documents.map { image in
            var newImage = image
            newImage.isBookmark = bookmarkImages.keys.contains(image.imageUrl)
            return newImage
        }
        
        if page == 1 {
            searchImages = imagesWithBookmarkStatus
        } else {
            searchImages.append(contentsOf: imagesWithBookmarkStatus)
        }
        
        return ImageSearchResponse(documents: searchImages, meta: result.meta)
    }
    
    func getbookmarkImages() -> [ImageData] {
        return Array(bookmarkImages.values)
    }
    
    func addBookmark(_ image: ImageData) {
        guard bookmarkImages[image.imageUrl] == nil else { return }
        
        var bookmarkedImage = image
        bookmarkedImage.isBookmark = true
        bookmarkImages[image.imageUrl] = bookmarkedImage
        
        updatesearchImagesBookmarkStatus(imageUrl: image.imageUrl, isBookmark: true)
    }
    
    func removeBookmark(_ image: ImageData) {
        if bookmarkImages[image.imageUrl] == nil {
            return
        }
        
        bookmarkImages.removeValue(forKey: image.imageUrl)
        
        updatesearchImagesBookmarkStatus(imageUrl: image.imageUrl, isBookmark: false)
        
    }
    
    func isBookmark(_ image: ImageData) -> Bool {
        return bookmarkImages[image.imageUrl] != nil
    }
    
    func toggleBookmark(_ image: ImageData) {
        if isBookmark(image) {
            removeBookmark(image)
        } else {
            addBookmark(image)
        }
    }
    
    func clearSearchDataAll() {
        searchImages.removeAll()
    }
    
    
    private func updatesearchImagesBookmarkStatus(imageUrl: String, isBookmark: Bool) {
        if let index = searchImages.firstIndex(where: { $0.imageUrl == imageUrl }) {
            searchImages[index].isBookmark = isBookmark
            bookmarkDidChange.send(imageUrl)
        }
    }
}

