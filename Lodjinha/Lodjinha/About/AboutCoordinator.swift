//
//  AboutCoordinator.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class AboutCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        setupTabBarItem()
    }

    private func setupTabBarItem() {
        navigationController.tabBarItem = UITabBarItem(title: L10n.aboutTab,
                                                       image: Asset.tagDeselected.image,
                                                       selectedImage: Asset.tagSelected.image)
    }
}

// MARK: - Coordinator

extension AboutCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return navigationController
    }

    func start() {
        let aboutController: AboutViewController = AboutViewController()
        navigationController.pushViewController(aboutController, animated: false)
    }
}
