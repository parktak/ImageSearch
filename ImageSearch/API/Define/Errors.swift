//
//  Errors.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/16/26.
//

import Foundation

struct Errors {
    static let InvalidUrl = NSError(domain: "API", code: 1000, userInfo: [NSLocalizedDescriptionKey : "InvalidUrl Url"])
    static let ResponseStatusCodeParsingError = NSError(domain: "API", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Response StatusCode parsing error"])
    static func responseMessage(message: String, code: Int) -> NSError  {
        return NSError(domain: "API", code: code, userInfo: [NSLocalizedDescriptionKey : message])
    }
    
    static let InvalidImageData = NSError(domain: "image", code: 2100, userInfo: [NSLocalizedDescriptionKey : "InvalidUrl Image Data"])
    
}
