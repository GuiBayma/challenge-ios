//
//  BestSellersAPI.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol BestSellersApiProtocol {
    func getBestSellers(completion: @escaping (Result<BestSellersData, NetworkError>) -> Void)
    func getBestSellerImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class BestSellersAPI {
    private let router: NetworkRouter

    init(router: NetworkRouter = Router()) {
        self.router = router
    }
}

// MARK: - BestSellersApiProtocol

extension BestSellersAPI: BestSellersApiProtocol {
    func getBestSellers(completion: @escaping (Result<BestSellersData, NetworkError>) -> Void) {
        let endpoint: EndPoint = EndPoint(path: "/produto/maisvendidos")
        router.request(endpoint) { result in
            switch result {
            case let .success(data):
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let apiResponse: BestSellersData = try decoder.decode(BestSellersData.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getBestSellerImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        router.requestImage(imageUrl, completion: completion)
    }
}
