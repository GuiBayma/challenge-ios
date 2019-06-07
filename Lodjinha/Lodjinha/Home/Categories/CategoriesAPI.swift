//
//  CategoriesAPI.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol CategoriesApiProtocol {
    func getCategories(completion: @escaping (Result<CategoriesData, NetworkError>) -> Void)
    func getCategoryImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class CategoriesAPI {
    private let router: NetworkRouter

    init(router: NetworkRouter = Router()) {
        self.router = router
    }
}

// MARK: - CategoriesApiProtocol

extension CategoriesAPI: CategoriesApiProtocol {
    func getCategories(completion: @escaping (Result<CategoriesData, NetworkError>) -> Void) {
        let endpoint: EndPoint = EndPoint(path: "/categoria")
        router.request(endpoint) { result in
            switch result {
            case let .success(data):
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let apiResponse: CategoriesData = try decoder.decode(CategoriesData.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getCategoryImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        router.requestImage(imageUrl, completion: completion)
    }
}
