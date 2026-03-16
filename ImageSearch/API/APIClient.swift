//
//  APIClient.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/16/26.
//

import Foundation
import Combine


class APIClient {
    func getImageList() async throws -> [ImageData] {
        let url = ""
        let request = APIRequest(url: url)
        
        let response = try await NetworkManager.request(request, responseType: ImageData.self)
        
        // kakao API response 확인 후 코드 추가/수정 필요
        
        return []
    }
    
}

// API
struct ImageData: Codable {
    let url: String
}
