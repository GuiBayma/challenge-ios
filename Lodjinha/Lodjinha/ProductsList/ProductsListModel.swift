//
//  ProductsListModel.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

struct ProductsListData: Decodable {
    var data: [BestSellersResponse]
    var offset: Int
    var total: Int
}

struct Product {
    // swiftlint:disable identifier_name
    var id: Int
    var name: String
    var imageUrlString: String
    var description: String
    var image: UIImage?
    var oldPrice: Float
    var currentPrice: Float
    var categoryName: String
}
