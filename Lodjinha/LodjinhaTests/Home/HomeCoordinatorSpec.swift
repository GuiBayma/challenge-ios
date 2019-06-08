//
//  HomeCoordinatorSpec.swift
//  LodjinhaTests
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Nimble
import Quick
import UIKit
@testable import Lodjinha

class HomeCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("HomeCoordinator") {
            var sut: HomeCoordinator!
            var rootController: UIViewController!

            beforeEach {
                sut = HomeCoordinator()
                sut.start()
                rootController = sut.rootViewController
            }

            context("rootViewController") {
                it("should have navigation controller as root controller") {
                    expect(rootController).to(beAKindOf(UINavigationController.self))
                }

                it("should have HomeViewController as root controller from navigation controller") {
                    let navigationController = rootController as? UINavigationController
                    let firstController = navigationController?.viewControllers.first
                    expect(firstController).to(beAKindOf(HomeViewController.self))
                }
            }

            context("Tab bar item") {
                it("should have the correct title") {
                    expect(rootController.tabBarItem.title) == L10n.homeTab
                }

                it("should have the correct image") {
                    expect(rootController.tabBarItem.image) == Asset.homeDeselected.image
                }
            }

            context("Navigation Delegate") {
                it("should conform to HomeViewControllerNavigationDelegate") {
                    expect(sut).to(beAKindOf(HomeViewControllerNavigationDelegate.self))
                }

                it("should conform to ProductsListControllerNavigationDelegate") {
                    expect(sut).to(beAKindOf(ProductsListControllerNavigationDelegate.self))
                }

                it("should conform to ProductDetailControllerNavigationDelegate") {
                    expect(sut).to(beAKindOf(ProductDetailControllerNavigationDelegate.self))
                }
            }
        }
    }
}
