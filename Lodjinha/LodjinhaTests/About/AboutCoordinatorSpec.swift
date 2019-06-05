//
//  AboutCoordinatorSpec.swift
//  LodjinhaTests
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Nimble
import Quick
import UIKit
@testable import Lodjinha

class AboutCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("AboutCoordinator") {
            var sut: AboutCoordinator!
            var rootController: UIViewController!

            beforeEach {
                sut = AboutCoordinator()
                sut.start()
                rootController = sut.rootViewController
            }

            context("rootViewController") {
                it("should have navigation controller as root controller") {
                    expect(rootController).to(beAKindOf(UINavigationController.self))
                }

                it("should have AboutViewController as root controller from navigation controller") {
                    let navigationController = rootController as? UINavigationController
                    let firstController = navigationController?.viewControllers.first
                    expect(firstController).to(beAKindOf(AboutViewController.self))
                }
            }

            context("Tab bar item") {
                it("should have the correct title") {
                    expect(rootController.tabBarItem.title) == L10n.aboutTab
                }

                it("should have the correct image") {
                    expect(rootController.tabBarItem.image) == Asset.tagDeselected.image
                }
            }
        }
    }
}
