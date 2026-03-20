//
//  ImageRepositoryImpl.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//


class ImageRepositoryImpl: ImageRepository {
    
    private let dataSource: ImageDataSource
    
    private var query = ""
    private var sortType: ImageSortType = .recency
    private var currentPage = 1
    private var isLastPage = false
    private var totalCount = 0
    private let pageSize = 10
    
    
    init(dataSource: ImageDataSource) {
        self.dataSource = dataSource
    }
    
    func searchImages(query: String, sortType: ImageSortType = .recency) async throws -> [ImageData] {
        
        self.query = query
        self.sortType = sortType
        currentPage = 1
        
        
        if query.isEmpty {
            isLastPage = true
            return []
        }
        
        return try await load()
    }
    
    func loadMore() async throws -> [ImageData] {
        guard canLoadMore() else { return [] }
        
        currentPage += 1
        
        return try await load()
    }
    
    private func load() async throws -> [ImageData] {
        let (images, isLasPage) = try await dataSource.searchImages(query: query, sortType: sortType, size: pageSize, page: currentPage)
        
        isLastPage = isLasPage
        return images
    }
    
    func canLoadMore() -> Bool {
        return !isLastPage && !query.isEmpty
    }
    
}
