//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol HomeViewControllerNavigationDelegate: AnyObject {
    func homeViewController(_ controller: HomeViewController, didSelect category: Category)
    func homeViewController(_ controller: HomeViewController, didSelect product: Product)
}

final class HomeViewController: UIViewController {

    weak var navigationDelegate: HomeViewControllerNavigationDelegate?
    private lazy var homeView: HomeView = HomeView(delegateSource: self)
    private let tableViewHandler: TableViewHandlerDelegate

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(handler: TableViewHandlerDelegate = TableViewHandler()) {
        tableViewHandler = handler
        super.init(nibName: nil, bundle: nil)
        tableViewHandler.delegate = self
    }

    // MARK: - Controller lifecycle

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    // MARK: - Navigation Bar setup

    private func setupNavigationBar() {
        navigationController?.configureNavigationBar(with: Asset.logoNavbar.image)
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product: Product = tableViewHandler.tableView(tableView, didSelectRowAt: indexPath) {
            navigationDelegate?.homeViewController(self, didSelect: product)
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewHandler.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewHandler.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewHandler.tableView(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewHandler.tableView(tableView, viewForHeaderInSection: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHandler.tableView(tableView, heightForHeaderInSection: section)
    }
}

// MARK: - TableViewHandlerActionDelegate

extension HomeViewController: TableViewHandlerActionDelegate {
    func updateTableView(section: Int) {
        homeView.reloadTableViewSections(at: [section])
    }

    func updateTableView(section: Int, row: Int) {
        homeView.reloadTableViewRows(at: [IndexPath(row: row, section: section)])
    }

    func didSelectCollectionItem(category: Category) {
        navigationDelegate?.homeViewController(self, didSelect: category)
    }
}
