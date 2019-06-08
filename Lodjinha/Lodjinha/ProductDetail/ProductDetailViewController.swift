//
//  ProductDetailViewController.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class ProductDetailViewController: UIViewController {

    private let productDetailView: ProductDetailView = ProductDetailView()
    private let product: Product

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Controller lifecycle

    override func loadView() {
        self.view = productDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        productDetailView.setProduct(product)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Navigation Bar setup

    private func setupNavigationBar() {
        navigationController?.configureNavigationBar(with: product.categoryName)
    }
}
