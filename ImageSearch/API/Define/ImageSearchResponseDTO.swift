//
//  ImageSearchResponseDTO.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/21/26.
//

import Foundation

struct ImageSearchResponseDTO: Codable {
    let documents: [ImageDTO]
    let meta: MetaDTO
}

struct ImageDTO: Codable {
    let collection: String
    let datetime: String
    let displaySitename: String
    let docUrl: String
    let height: Int
    let imageUrl: String
    let thumbnailUrl: String
    let width: Int
    
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

struct MetaDTO: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}


extension ImageDTO {
    func toDomain(isBookmark: Bool = false) -> ImageData {
        return ImageData(
            height: height,
            imageUrl: imageUrl,
            thumbnailUrl: thumbnailUrl,
            width: width
        )
    }
}

extension MetaDTO {
    func toDomain() -> Meta {
        return Meta(
            isEnd: isEnd,
            pageableCount: pageableCount,
            totalCount: totalCount
        )
    }
}

extension ImageSearchResponseDTO {
    func toDomain(bookmarkedUrls: Set<String> = []) -> ImageSearchResponse {
        let domainDocuments = documents.map { dto in
            dto.toDomain(isBookmark: bookmarkedUrls.contains(dto.imageUrl))
        }
        
        return ImageSearchResponse(
            documents: domainDocuments,
            meta: meta.toDomain()
        )
    }
}
