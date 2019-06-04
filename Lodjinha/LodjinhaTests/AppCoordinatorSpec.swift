//
//  AppCoordinatorSpec.swift
//  LodjinhaTests
//
//  Created by Guilherme Bayma on 04/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Nimble
import Quick
import UIKit
@testable import Lodjinha

class AppCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("AppCoordinator") {
            var sut: AppCoordinator!
            var window: UIWindow!
            var tabController: UITabBarController!

            beforeEach {
                window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
                tabController = UITabBarController()
                sut = AppCoordinator(window: window, tabController: tabController)
                sut.start()
            }

            context("TabBarController number of controllers") {
                it("should have two controllers") {
                    expect(tabController.viewControllers?.count) == 2
                }
            }

            context("First controller from Tab Bar Controller") {
                it("should have the correct title") {
                    let firstController = tabController.viewControllers?.first
                    expect(firstController?.tabBarItem.title) == L10n.homeTab
                }

                it("should have the correct image") {
                    let firstController = tabController.viewControllers?.first
                    expect(firstController?.tabBarItem.image) == Asset.homeDeselected.image
                }
            }

            context("Second controller from Tab Bar Controller") {
                it("should have the correct title") {
                    let secondController = tabController.viewControllers?[1]
                    expect(secondController?.tabBarItem.title) == L10n.aboutTab
                }

                it("should have the correct image") {
                    let secondController = tabController.viewControllers?[1]
                    expect(secondController?.tabBarItem.image) == Asset.tagDeselected.image
                }
            }
        }
    }
}
