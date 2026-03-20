//
//  APIClient.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/16/26.
//

import Foundation
import Combine


enum ImageSortType: String {
    case accuracy = "accuracy"
    case recency = "recency"
}

class APIClient {
    static let KAKAO_API_KEY = "bdb2ffa09431876eb9ec34cf7939f6b4"
    static let baseUrl = "https://dapi.kakao.com"
    
    func getImageList(
        _ query: String,
        sortType: ImageSortType = .recency,
        size: Int = 3,
        page: Int = 1,
        bookmarkedUrls: Set<String> = []
    ) async throws -> ImageSearchResponse {
        let url =  "/v2/search/image"
        let header = getAuthorization()
        
        let body: [String : Any] = ["query": query,
                                    "size": size,
                                    "page": page,
                                    "sort": sortType.rawValue]
        
        let request = APIRequest(baseUrl: APIClient.baseUrl, url: url, headers: header, body: body)
        
        let responseDTO = try await NetworkManager.request(request, responseType: ImageSearchResponseDTO.self)
        
        return responseDTO.toDomain(bookmarkedUrls: bookmarkedUrls)
    }
    
    private func getAuthorization() -> [String: String] {
        return ["Authorization" : "KakaoAK \(APIClient.KAKAO_API_KEY)"]
    }
}
