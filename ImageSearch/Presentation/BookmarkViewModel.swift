//
//  BookmarkViewModel.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation
import Combine

class BookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarkedImages: [ImageData] = []
    
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
        loadBookmarks()
    }
    
    func loadBookmarks() {
        bookmarkedImages = repository.getBookmarkImages()
    }
    
    func removeBookmark(_ image: ImageData) {
        repository.toggleBookmark(image)
        loadBookmarks()
    }
}
