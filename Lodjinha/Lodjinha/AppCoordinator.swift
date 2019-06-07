//
//  AppCoordinator.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 03/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController { get }
    func start()
}

final class AppCoordinator {
    private let window: UIWindow
    private let tabController: UITabBarController
    private var coordinators: [Coordinator] = []

    init(window: UIWindow, tabController: UITabBarController = UITabBarController()) {
        self.window = window
        self.tabController = tabController
        setupTabBar()
    }

    private func setupTabBar() {
        tabController.tabBar.tintColor = UIColor.Purple
        tabController.viewControllers = setupTabControllers()
    }

    private func setupTabControllers() -> [UIViewController] {
        let homeCoordinator: HomeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        coordinators.append(homeCoordinator)

        let aboutCoordinator: AboutCoordinator = AboutCoordinator()
        aboutCoordinator.start()
        coordinators.append(aboutCoordinator)

        return [homeCoordinator.rootViewController,
                aboutCoordinator.rootViewController]
    }
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return tabController
    }

    func start() {
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }
}
