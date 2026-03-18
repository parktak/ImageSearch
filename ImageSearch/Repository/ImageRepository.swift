//
//  ImageRepository.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation
import Combine

protocol ImageRepository {
    func searchImages(query: String, sortType: ImageSortType) async throws -> [ImageData]
    func loadMore() async throws -> [ImageData]
    func canLoadMore() -> Bool
    func getBookmarkImages() -> [ImageData]
    func toggleBookmark(_ image: ImageData)
    func isBookmark(_ image: ImageData) -> Bool
}
