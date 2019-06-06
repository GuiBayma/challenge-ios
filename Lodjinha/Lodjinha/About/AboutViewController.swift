//
//  AboutViewController.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 04/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController {

    private let aboutView: AboutView = AboutView()

    // MARK: - Controller lifecycle

    override func loadView() {
        self.view = aboutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    // MARK: - Navigation Bar setup

    private func setupNavigationBar() {
        navigationController?.configureNavigationBar(with: L10n.aboutTab)
    }
}
