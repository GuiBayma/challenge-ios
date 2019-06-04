//
//  UINavigationController+StatusBar.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 04/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
