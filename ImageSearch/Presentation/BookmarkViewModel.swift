//
//  BookmarkViewModel.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation
import Combine

class BookmarkViewModel: BookmarkController {
    
    @Published private(set) var bookmarkedImages: [ImageData] = []
    @Published private(set) var isLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    private let repository: BookmarkRepository
    
    
    init(repository: BookmarkRepository) {
        self.repository = repository
        loadBookmarks()
        repository.bookmarkDidChange.sink { [weak self] imageUrl in
            self?.loadBookmarks()
            
        }
        .store(in: &cancellables)
    }
    
    func loadBookmarks() {
        if isLoading {
            return
        }
        isLoading = true
        bookmarkedImages = repository.getBookmarkImages()
        isLoading = false
    }
    
    func toggleBookmark(_ image: ImageData) {
        repository.toggleBookmark(image)
        loadBookmarks()
    }
}
