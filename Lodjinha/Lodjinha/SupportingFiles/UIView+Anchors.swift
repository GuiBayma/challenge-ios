//
//  UIView+Anchors.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 04/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol ViewConfiguration {
    func setupViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfiguration {
    func setupViewHierarchy() {}
    func setupConstraints() {}
    func configureViews() {}

    func setupView() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
}

extension UIView {
    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func widthAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1) -> Self {
        widthAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier).isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1) -> Self {
        heightAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier).isActive = true
        return self
    }

    @discardableResult
    func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
}
