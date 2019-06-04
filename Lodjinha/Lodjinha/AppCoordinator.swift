//
//  AppCoordinator.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 03/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

final class AppCoordinator {
    private let window: UIWindow
    private let tabController: UITabBarController

    init(window: UIWindow) {
        self.window = window
        tabController = UITabBarController()
        setupTabBar()
    }

    private func setupTabBar() {
        tabController.tabBar.tintColor = UIColor.Theme.Purple
        tabController.viewControllers = setupTabControllers()
    }

    private func setupTabControllers() -> [UIViewController] {
        let homeController = UIViewController() // Type inference
        homeController.view.backgroundColor = .white
        homeController.tabBarItem = UITabBarItem(title: "Home",
                                                 image: Asset.homeDeselected.image,
                                                 selectedImage: Asset.homeActive.image)

        let aboutController = UIViewController() // Type inference
        aboutController.view.backgroundColor = .cyan
        aboutController.tabBarItem = UITabBarItem(title: "Sobre",
                                                 image: Asset.tagDeselected.image,
                                                 selectedImage: Asset.tagSelected.image)

        return [homeController, aboutController]
    }
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {
    func start() {
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }
}
