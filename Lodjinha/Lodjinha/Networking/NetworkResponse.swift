//
//  NetworkResponse.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 06/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case emptyResponse
    case unauthorized
    case forbidden
    case notFound
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}
