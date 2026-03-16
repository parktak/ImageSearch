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
    let body: Data?
    
    init(
        url: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: Data? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


struct APIResponse {
    let statusCode: Int
    let response: Data
}
