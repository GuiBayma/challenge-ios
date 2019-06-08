//
//  EndPoint.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 06/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct EndPoint {
    var url: URL?
    var httpMethod: HTTPMethod
    var headers: HTTPHeaders?

    init(path: String,
         queryItems: [URLQueryItem] = [],
         method: HTTPMethod = .get,
         headers: HTTPHeaders? = nil) {

        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = "alodjinha.herokuapp.com"
        components.path = path
        components.queryItems = queryItems

        self.url = components.url
        self.httpMethod = method
        self.headers = headers
    }

    init(urlString: String,
         method: HTTPMethod = .get,
         headers: HTTPHeaders? = nil) {

        url = URL(string: urlString)
        self.httpMethod = method
        self.headers = headers
    }
}
