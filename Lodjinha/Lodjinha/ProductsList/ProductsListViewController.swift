//
//  ProductsListViewController.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class ProductsListViewController: UIViewController {

    private let category: Category
    private let delegateSource: TableViewDelegateDataSource
    private lazy var productsListView: ProductsListView = ProductsListView(delegateSource: delegateSource)

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(category: Category,
         delegateSource: TableViewDelegateDataSource = ProductsListTableViewDelegateSource()) {
        self.category = category
        self.delegateSource = delegateSource
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Controller lifecycle

    override func loadView() {
        self.view = productsListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    // MARK: - Navigation Bar setup

    private func setupNavigationBar() {
        navigationController?.configureNavigationBar(with: category.description)
    }
}
