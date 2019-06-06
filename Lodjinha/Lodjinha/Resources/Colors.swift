//
//  Colors.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 03/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

extension UIColor {
    struct Background {
        static let White: UIColor = UIColor(red: 1,
                                            green: 1,
                                            blue: 1,
                                            alpha: 1.0)

        static let Purple: UIColor = UIColor(red: 105.0/255.0,
                                             green: 65.0/255.0,
                                             blue: 143.0/255.0,
                                             alpha: 1.0)

        static let LightGray: UIColor = UIColor(red: 220.0/255.0,
                                                green: 220.0/255.0,
                                                blue: 220.0/255.0,
                                                alpha: 1.0)

        static let DarkGray: UIColor = UIColor(white: 1,
                                               alpha: 0.4)
    }

    struct Text {
        static let Gray: UIColor = UIColor(red: 74.0/255.0,
                                           green: 74.0/255.0,
                                           blue: 74.0/255.0,
                                           alpha: 1.0)
    }
}
