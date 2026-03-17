//
//  NetworkManager.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/16/26.
//


import Foundation


class NetworkManager {
    
    static func request<T: Decodable>(_ request: APIRequest, responseType: T.Type) async throws -> T {
        
        var finalURL: URL
        
        if request.method == .get, let body = request.body, !body.isEmpty {
            guard var urlComponents = URLComponents(string: request.url) else {
                throw Errors.InvalidUrl
            }
            
            var queryItems = urlComponents.queryItems ?? []
            for (key, value) in body {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else {
                throw Errors.InvalidUrl
            }
            finalURL = url
            
        } else {
            guard let url = URL(string: request.url) else {
                throw Errors.InvalidUrl
            }
            finalURL = url
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if request.method != .get, let body = request.body {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
#if DEBUG
        if let dataString = String(data: data, encoding: .utf8) {
            print(dataString)
        }
#endif
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
