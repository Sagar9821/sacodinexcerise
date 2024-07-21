//
//  APIConstants.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authentication"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
}

enum ContentType: String {
    case json = "application/json"
}

struct Empty: Codable {}
