//
//  ImageRepository.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import Foundation
import Combine

protocol ImageRepository {
    func searchImages(query: String, sortType: ImageSortType, size: Int, page: Int) async throws -> ImageSearchResponse
    func getBookmarkImages() -> [ImageData]
    func toggleBookmark(_ image: ImageData)
    func isBookmark(_ image: ImageData) -> Bool
}
