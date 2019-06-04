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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Controller lifecycle

    override func loadView() {
        self.view = aboutView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    // MARK: - Navigation Bar setup

    private func setupNavigationBar() {
        setupBarTitle()
        setupBarBackground()
        setupBarShadow()
    }

    private func setupBarTitle() {
        navigationItem.title = L10n.aboutTab
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    private func setupBarBackground() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.Background.Purple
    }

    private func setupBarShadow() {
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 3.0
        navigationController?.navigationBar.layer.shadowOpacity = 1.0
        navigationController?.navigationBar.layer.masksToBounds = false
    }
}
