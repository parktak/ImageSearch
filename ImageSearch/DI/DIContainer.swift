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
    
    private func createImageRepository() -> ImageRepository {
        return ImageRepositoryImpl(dataSource: self.dataSource)
    }
    
    private func createImageViewModel() -> ImageViewModel {
        ImageViewModel(repository: createImageRepository())
    }
    
    private func createBookmarViewModel() -> BookmarkViewModel {
        BookmarkViewModel(repository: createImageRepository())
    }
}
