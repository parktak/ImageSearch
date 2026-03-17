//
//  ImageRepositoryImpl.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//


class ImageRepositoryImpl: ImageRepository {
    private let dataSource: ImageDataSource
    
    init(dataSource: ImageDataSource) {
        self.dataSource = dataSource
    }
    
    func searchImages(query: String, sortType: ImageSortType = .recency, size: Int, page: Int) async throws -> ImageSearchResponse {
        return try await dataSource.searchImages(query: query, sortType: sortType, size: size, page: page)
    }
    
    func getBookmarkImages() -> [ImageData] {
        return dataSource.getBookmarkedImages()
    }
    
    func toggleBookmark(_ image: ImageData) {
        dataSource.toggleBookmark(image)
    }
    
    func isBookmark(_ image: ImageData) -> Bool {
        return dataSource.isBookmark(image)
    }
}
