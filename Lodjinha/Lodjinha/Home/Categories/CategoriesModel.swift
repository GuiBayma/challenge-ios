//
//  CategoriesModel.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

struct CategoriesData: Decodable {
    var data: [CategoriesResponse]
}

struct CategoriesResponse: Decodable {
    // swiftlint:disable identifier_name
    var id: Int
    var descricao: String
    var urlImagem: String
}

struct Category {
    var descricao: String
    var imagem: UIImage?
}
