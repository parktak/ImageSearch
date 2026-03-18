//
//  BookmarkRepository.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/18/26.
//

import Foundation
import Combine

protocol BookmarkRepository {
    var bookmarkDidChange: AnyPublisher<String, Never> { get }
    func getBookmarkImages() -> [ImageData]
    func toggleBookmark(_ image: ImageData)
    func isBookmark(_ image: ImageData) -> Bool
}
