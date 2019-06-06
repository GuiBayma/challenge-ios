//
//  BannerAPI.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 06/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case badURL
}

protocol BannerApiProtocol {
    func getBanners(completion: @escaping (Result<BannerData, NetworkError>) -> Void)
    func getBannerImage(imageUrl: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class BannerAPI: BannerApiProtocol {
    func getBanners(completion: @escaping (Result<BannerData, NetworkError>) -> Void) {
        
    }

    func getBannerImage(imageUrl: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {

    }
}
