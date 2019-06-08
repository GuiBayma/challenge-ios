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
        let productsListController: ProductsListViewController = ProductsListViewController(category: category)
        navigationController.pushViewController(productsListController, animated: true)
    }
}
