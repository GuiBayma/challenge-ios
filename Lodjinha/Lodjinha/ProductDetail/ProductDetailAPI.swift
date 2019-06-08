//
//  ProductDetailAPI.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Foundation

protocol ProductDetailApiProtocol {
    func reserveProduct(with identifier: Int, completion: @escaping (Result<ReservationResponse, NetworkError>) -> Void)
}

final class ProductDetailAPI {
    private let router: NetworkRouter

    init(router: NetworkRouter = Router()) {
        self.router = router
    }
}

extension ProductDetailAPI: ProductDetailApiProtocol {
    func reserveProduct(with identifier: Int, completion: @escaping (Result<ReservationResponse, NetworkError>) -> Void) {
        let endpoint: EndPoint = EndPoint(path: "/produto/\(identifier)", method: .post)
        router.request(endpoint) { result in
            switch result {
            case let .success(data):
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let apiResponse: ReservationResponse = try decoder.decode(ReservationResponse.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
