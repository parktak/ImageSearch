//
//  BookmarkController.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/20/26.
//

import Combine

protocol BookmarkController where Self: ObservableObject {
    func toggleBookmark(_ image: ImageData)
}
