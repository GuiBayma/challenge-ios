//
//  HomeCoordinator.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class HomeCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        setupTabBarItem()
    }

    private func setupTabBarItem() {
        navigationController.tabBarItem = UITabBarItem(title: L10n.homeTab,
                                                       image: Asset.homeDeselected.image,
                                                       selectedImage: Asset.homeActive.image)
    }

    private func setupBackButton(_ controller: UIViewController, title: String) {
        let backItem: UIBarButtonItem = UIBarButtonItem()
        backItem.title = title
        controller.navigationItem.backBarButtonItem = backItem
    }
}

// MARK: - Coordinator

extension HomeCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return navigationController
    }

    func start() {
        let homeController = HomeViewController()
        homeController.navigationDelegate = self
        navigationController.pushViewController(homeController, animated: false)
    }
}

// MARK: - HomeViewControllerNavigationDelegate

extension HomeCoordinator: HomeViewControllerNavigationDelegate {
    func homeViewController(_ controller: HomeViewController, didSelect category: Category) {
        setupBackButton(controller, title: L10n.homeTab)
        let productsListController: ProductsListViewController = ProductsListViewController(category: category)
        productsListController.navigationDelegate = self
        navigationController.pushViewController(productsListController, animated: true)
    }

    func homeViewController(_ controller: HomeViewController, didSelect product: Product) {
        setupBackButton(controller, title: L10n.backNavigationButton)
        let productDetailController: ProductDetailViewController = ProductDetailViewController(product: product)
        navigationController.pushViewController(productDetailController, animated: true)
    }
}

// MARK: - ProductsListControllerNavigationDelegate

extension HomeCoordinator: ProductsListControllerNavigationDelegate {
    func productsListController(_ controller: ProductsListViewController, didSelect product: Product) {
        setupBackButton(controller, title: L10n.backNavigationButton)
        let productDetailController: ProductDetailViewController = ProductDetailViewController(product: product)
        navigationController.pushViewController(productDetailController, animated: true)
    }
}
