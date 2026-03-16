//
//  NetworkManager.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/16/26.
//


import Foundation


class NetworkManager {
    
    static func request<T: Decodable>(_ request: APIRequest, responseType: T.Type) async throws -> T {
        
        guard let url = URL(string: request.url) else {
            throw Errors.InvalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let body = request.body {
            urlRequest.httpBody = body
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw Errors.ResponseStatusCodeParsingError
        }
        
        let statusCode = httpResponse.statusCode
        // kakaoAPI response code 확인 후 수정해야 할 수도 있음!
        guard statusCode == 200 else {
            throw Errors.responseMessage(
                message: HTTPURLResponse.localizedString(forStatusCode: statusCode),
                code: statusCode
            )
        }
        
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        
        return decodedData
    }
    
}
