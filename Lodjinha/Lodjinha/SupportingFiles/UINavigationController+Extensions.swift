//
//  UINavigationController+Extensions.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 04/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

extension UINavigationController {

    // MARK: - Status Bar Style

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Navigation Bar setup

    /// Configura navigationBar com um título (String)
    ///
    /// - Parameter title: String a ser usada como título
    func configureNavigationBar(with title: String) {
        setupBarTitle(title)
        setupBarBackground()
        setupBarShadow()
    }

    /// Configura navigationBar com uma imagem de título
    ///
    /// - Parameter image: UIImage a ser usada como título
    func configureNavigationBar(with image: UIImage) {
        setupBarTitleView(image)
        setupBarBackground()
        setupBarShadow()
    }

    private func setupBarTitle(_ title: String) {
        visibleViewController?.navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = textAttributes
    }

    private func setupBarTitleView(_ image: UIImage) {
        let imageView: UIImageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 127.84, height: 34)
        imageView.contentMode = .scaleAspectFit
        visibleViewController?.navigationItem.titleView = imageView
    }

    private func setupBarBackground() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.Purple
    }

    private func setupBarShadow() {
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationBar.layer.shadowRadius = 3.0
        navigationBar.layer.shadowOpacity = 1.0
        navigationBar.layer.masksToBounds = false
    }
}
