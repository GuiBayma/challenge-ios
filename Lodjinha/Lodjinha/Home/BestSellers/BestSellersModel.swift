//
//  BestSellersModel.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

struct BestSellersData: Decodable {
    var data: [BestSellersResponse]
}

struct BestSellersResponse: Decodable {
    // swiftlint:disable identifier_name
    var id: Int
    var nome: String
    var urlImagem: String
    var descricao: String
    var precoDe: Float
    var precoPor: Float
    var categoria: CategoriesResponse
}
