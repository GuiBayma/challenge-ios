//
//  BannerAPI.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 06/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol BannerApiProtocol {
    func getBanners(completion: @escaping (Result<BannerData, NetworkError>) -> Void)
    func getBannerImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class BannerAPI {
    private let router: NetworkRouter

    init(router: NetworkRouter = Router()) {
        self.router = router
    }
}

// MARK: - BannerApiProtocol

extension BannerAPI: BannerApiProtocol {
    func getBanners(completion: @escaping (Result<BannerData, NetworkError>) -> Void) {
        let endpoint: EndPoint = EndPoint(path: "/banner")
        router.request(endpoint) { result in
            switch result {
            case let .success(data):
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let apiResponse: BannerData = try decoder.decode(BannerData.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getBannerImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let endpoint: EndPoint = EndPoint(urlString: imageUrl)
        router.request(endpoint) { result in
            switch result {
            case let .success(data):
                if let image: UIImage = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(.unableToDecode))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
