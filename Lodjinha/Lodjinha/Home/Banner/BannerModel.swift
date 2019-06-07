//
//  BannerModel.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 06/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

struct BannerData: Decodable {
    var data: [BannerResponse]
}

struct BannerResponse: Decodable {
    // swiftlint:disable identifier_name
    var id: Int
    var urlImagem: String
    var linkUrl: String
}

struct Banner {
    var image: UIImage?
}
