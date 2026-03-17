//
//  APIDefine.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/16/26.
//

import Foundation



struct APIRequest {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: [String: Any]?
    
    init(
        baseUrl: String,
        url: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil
    ) {
        self.url = baseUrl + url
        self.method = method
        self.headers = headers
        self.body = body
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct ImageSearchResponse: Codable {
    let documents: [ImageData]
    let meta: Meta
}

struct ImageData: Codable {
    let collection: String
    let datetime: String
    let displaySitename: String
    let docUrl: String
    let height: Int
    let imageUrl: String
    let thumbnailUrl: String
    let width: Int
    var isBookmark = false
    
    enum CodingKeys: String, CodingKey {
        case collection
        case datetime
        case displaySitename = "display_sitename"
        case docUrl = "doc_url"
        case height
        case imageUrl = "image_url"
        case thumbnailUrl = "thumbnail_url"
        case width
    }
}

struct Meta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

