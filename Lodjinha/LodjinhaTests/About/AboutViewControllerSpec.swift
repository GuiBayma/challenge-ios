//
//  AboutViewControllerSpec.swift
//  LodjinhaTests
//
//  Created by Guilherme Bayma on 04/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import Quick
import UIKit
@testable import Lodjinha

class AboutViewControllerSpec: QuickSpec {

    override func spec() {
        describe("AboutViewController") {
            var sut: AboutViewController!
            var navigation: UINavigationController!
            var tabBar: UITabBarController!

            context("Without navigation or tab bar") {
                beforeEach {
                    sut = AboutViewController()

                    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
                    window.rootViewController = sut
                    window.makeKeyAndVisible()
                }

                it("should have a matching snapshot") {
                    expect(sut).to(haveValidSnapshot())
                }
            }

            context("With navigation") {
                beforeEach {
                    sut = AboutViewController()
                    navigation = UINavigationController(rootViewController: sut)

                    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
                    window.rootViewController = navigation
                    window.makeKeyAndVisible()
                }

                it("should have a matching snapshot") {
                    expect(navigation).to(haveValidSnapshot())
                }
            }

            context("With navigation and tab bar") {
                beforeEach {
                    sut = AboutViewController()
                    navigation = UINavigationController(rootViewController: sut)
                    tabBar = UITabBarController()
                    tabBar.viewControllers = [navigation]

                    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
                    window.rootViewController = tabBar
                    window.makeKeyAndVisible()
                }

                it("should have a matching snapshot") {
                    expect(tabBar).to(haveValidSnapshot())
                }
            }
        }
    }
}
