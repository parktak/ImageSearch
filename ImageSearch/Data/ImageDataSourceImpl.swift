//
//  ImageDataSourceImpl.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation

class ImageDataSourceImpl: ImageDataSource {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func searchImages(query: String, sortType: ImageSortType, size: Int, page: Int) async throws -> ImageSearchResponse {
        let result = try await apiClient.getImageList(query, sortType: sortType, size: size, page: page)
        return result
    }
    
    func getBookmarkedImages() -> [ImageData] {
        return []
    }
    
    func addBookmark(_ image: ImageData) {
    }
    
    func removeBookmark(_ image: ImageData) {
    }
    
    func isBookmark(_ image: ImageData) -> Bool {
        return true
    }
    
    func toggleBookmark(_ image: ImageData) {
        if isBookmark(image) {
            removeBookmark(image)
        } else {
            addBookmark(image)
        }
    }
}

