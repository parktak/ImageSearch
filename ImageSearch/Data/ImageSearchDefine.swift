//
//  ImageSearchDefine.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/21/26.
//

import Foundation


struct ImageSearchResponse {
    let documents: [ImageData]
    let meta: Meta
}

struct Meta {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int
}

struct ImageData {
    let height: Int
    let imageUrl: String
    let thumbnailUrl: String
    let width: Int
    var isBookmark = false
}


struct BookmarkData {
    let image: ImageData
    let registDate: Date
    
    var imageUrl: String {
        return image.imageUrl
    }
}



