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
    func anchorTo(view: UIView, inset: CGFloat = 0) -> Self {
        self
            .leadingAnchor(equalTo: view.leadingAnchor, constant: inset)
            .topAnchor(equalTo: view.topAnchor, constant: inset)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -inset)
            .bottomAnchor(equalTo: view.bottomAnchor, constant: -inset)
        return self
    }

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
    func widthAnchor(equalTo width: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1) -> Self {
        heightAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier).isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(equalTo height: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: height).isActive = true
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
