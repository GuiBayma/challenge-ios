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
        tabController.tabBar.tintColor = UIColor(red: 105.0/255.0, green: 65.0/255.0, blue: 143.0/255.0, alpha: 1)
        tabController.viewControllers = setupTabControllers()
    }

    private func setupTabControllers() -> [UIViewController] {
        let homeController = UIViewController() // Type inference
        homeController.view.backgroundColor = .white
        homeController.tabBarItem = UITabBarItem(title: "Home",
                                                 image: UIImage(named: "homeDeselected"),
                                                 selectedImage: UIImage(named: "homeActive"))

        let aboutController = UIViewController() // Type inference
        aboutController.view.backgroundColor = .cyan
        aboutController.tabBarItem = UITabBarItem(title: "Sobre",
                                                 image: UIImage(named: "tagDeselected"),
                                                 selectedImage: UIImage(named: "tagSelected"))

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
