//
//  ImageDataSource.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation
import Combine

//검색, 북마크 추가/삭제, 북마크 여부,,, 또 있나?
protocol ImageDataSource {
    var bookmarkDidChange: AnyPublisher<String, Never> { get }
    
    func searchImages(query: String, sortType: ImageSortType, size: Int, page: Int) async throws -> [ImageData]
    func getBookmarkData() -> [BookmarkData]
    func addBookmark(_ image: ImageData)
    func removeBookmark(_ image: ImageData)
    func isBookmark(_ image: ImageData) -> Bool
    func toggleBookmark(_ image: ImageData)
}
