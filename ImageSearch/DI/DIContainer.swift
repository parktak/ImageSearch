//
//  DIContainer.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation

class DIContainer {
    static let shared = DIContainer()
    
    let apiCLient = APIClient()
    lazy var dataSource: ImageDataSource = {
        return ImageDataSourceImpl(apiClient: self.apiCLient)
    }()
    private let cacheManager = ImageCacheManager()
    
    
    private func createImageRepository() -> ImageRepository {
        return ImageRepositoryImpl(dataSource: self.dataSource)
    }
    
    private func createBookmarkRepository() -> BookmarkRepository {
        return BookmarkRepositoryImpl(dataSource: self.dataSource)
    }
    
    func createImageViewModel() -> ImageViewModel {
        ImageViewModel(imageRepository: createImageRepository(), bookmarkRepository: createBookmarkRepository())
    }
    
    func createBookmarViewModel() -> BookmarkViewModel {
        BookmarkViewModel(repository: createBookmarkRepository())
    }
    
    func createImageLoader() -> ImageLoader {
        ImageLoader(imageCacher: self.cacheManager)
    }
}
