//
//  BookmarkRepositoryImpl.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/18/26.
//

import Foundation
import Combine

class BookmarkRepositoryImpl: BookmarkRepository {
    
    private let dataSource: ImageDataSource
    
    init(dataSource: ImageDataSource) {
        self.dataSource = dataSource
    }
    
    var bookmarkDidChange: AnyPublisher<String, Never> {
        return dataSource.bookmarkDidChange
    }
    
    func getBookmarkData() -> [BookmarkData] {
        return dataSource.getBookmarkData()
    }
    
    func toggleBookmark(_ image: ImageData) {
        dataSource.toggleBookmark(image)
    }
    
    func isBookmark(_ image: ImageData) -> Bool {
        return dataSource.isBookmark(image)
    }
}
