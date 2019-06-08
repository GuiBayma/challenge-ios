//
//  ProductsListAPI.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol ProductsListApiProtocol {
    func getProductsList(for category: Int,
                         offset: Int,
                         limit: Int,
                         completion: @escaping (Result<ProductsListData, NetworkError>) -> Void)
    func getProductImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class ProductsListAPI {
    private let router: NetworkRouter

    init(router: NetworkRouter = Router()) {
        self.router = router
    }
}

// MARK: - ProductsListApiProtocol

extension ProductsListAPI: ProductsListApiProtocol {
    func getProductsList(for category: Int,
                         offset: Int,
                         limit: Int,
                         completion: @escaping (Result<ProductsListData, NetworkError>) -> Void) {
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "categoriaId", value: "\(category)"),
                                          URLQueryItem(name: "offset", value: "\(offset)"),
                                          URLQueryItem(name: "limit", value: "\(limit)")]
        let endpoint: EndPoint = EndPoint(path: "/produto", queryItems: queryItems)
        router.request(endpoint) { result in
            switch result {
            case let .success(data):
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let apiResponse: ProductsListData = try decoder.decode(ProductsListData.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getProductImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        router.requestImage(imageUrl, completion: completion)
    }
}
