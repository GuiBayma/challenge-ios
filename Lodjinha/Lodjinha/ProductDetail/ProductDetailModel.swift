//
//  ProductDetailModel.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Foundation

struct ReservationResponse: Decodable {
    var result: String
}

enum ReservationResponseType {
    case success
    case failure

    init(responseString: String) {
        switch responseString {
        case "success":
            self = .success
        default:
            self = .failure
        }
    }
}
