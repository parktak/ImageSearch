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
    
    private var bookmarkData = [String: BookmarkData]()
    
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func searchImages(query: String, sortType: ImageSortType, size: Int, page: Int) async throws -> [ImageData] {
        let bookmarkedUrls = Set(bookmarkData.keys)
        let searchResponse = try await apiClient.getImageList(
            query,
            sortType: sortType,
            size: size,
            page: page,
            bookmarkedUrls: bookmarkedUrls
        )
        
        let images = searchResponse.documents.map { image in
            var newImage = image
            newImage.isBookmark = isBookmark(image)
            return image
        }
        
        return images
    }
    
    func getBookmarkData() -> [BookmarkData] {
        return Array(bookmarkData.values)
            .sorted { $0.registDate < $1.registDate }
    }
    
    func addBookmark(_ image: ImageData) {
        guard bookmarkData[image.imageUrl] == nil else { return }
        
        let bookmark = BookmarkData(
            image: image,
            registDate: Date()
        )
        bookmarkData[image.imageUrl] = bookmark
    }
    
    func removeBookmark(_ image: ImageData) {
        guard bookmarkData[image.imageUrl] != nil else { return }
        bookmarkData.removeValue(forKey: image.imageUrl)
    }
    
    func isBookmark(_ image: ImageData) -> Bool {
        return bookmarkData[image.imageUrl] != nil
    }
    
    func toggleBookmark(_ image: ImageData) {
        if isBookmark(image) {
            removeBookmark(image)
        } else {
            addBookmark(image)
        }
        
        bookmarkDidChangeSubject.send(image.imageUrl)
    }
    
}
