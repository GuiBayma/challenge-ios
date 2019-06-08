//
//  HomeViewControllerSpec.swift
//  LodjinhaTests
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import Quick
import UIKit
@testable import Lodjinha

class TableViewHandlerMock: TableViewHandlerDelegate {
    var delegate: TableViewHandlerActionDelegate?

    // Data Source

    func numberOfSections() -> Int {
        return 55
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return 77
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessibilityIdentifier = "TEST CELL"
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.accessibilityIdentifier = "TEST HEADER"
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33.3
    }

     // Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Product? {
        return Product(id: 0, name: "PRODUCT TEST NAME", imageUrlString: "", description: "", image: nil, oldPrice: 0, currentPrice: 0, categoryName: "")
    }
}

class HomeNavigationDelegateMock: HomeViewControllerNavigationDelegate {
    func homeViewController(_ controller: HomeViewController, didSelect category: Lodjinha.Category) {

    }

    var product: Product?
    func homeViewController(_ controller: HomeViewController, didSelect product: Product) {
        self.product = product
    }
}

class HomeViewControllerSpec: QuickSpec {

    override func spec() {
        describe("HomeViewController") {
            var sut: HomeViewController!
            var handlerMock: TableViewHandlerMock!
            var navigationDelegateMock: HomeNavigationDelegateMock!
            var navigation: UINavigationController!

            beforeEach {
                handlerMock = TableViewHandlerMock()
                navigationDelegateMock = HomeNavigationDelegateMock()
                sut = HomeViewController(handler: handlerMock)
                sut.navigationDelegate = navigationDelegateMock
                navigation = UINavigationController(rootViewController: sut)

                let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
                window.rootViewController = navigation
                window.makeKeyAndVisible()
            }

            context("With navigation") {
                it("should have a matching snapshot") {
                    expect(navigation).to(haveValidSnapshot())
                }
            }

            context("TableViewHandlerDelegate") {
                context("TableViewHandlerActionDelegate") {
                    it("should conform to TableViewHandlerActionDelegate") {
                        expect(sut).to(beAKindOf(TableViewHandlerActionDelegate.self))
                    }
                }

                context("UITableViewDelegate") {
                    it("should return a Product") {
                        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
                        expect(navigationDelegateMock.product?.name) == "PRODUCT TEST NAME"
                    }
                }

                context("UITableViewDataSource") {
                    it("should return the correct number of sections") {
                        let sections = sut.numberOfSections(in: UITableView())
                        expect(sections) == 55
                    }

                    it("should return the correct number of rows for section") {
                        let rows = sut.tableView(UITableView(), numberOfRowsInSection: 0)
                        expect(rows) == 77
                    }

                    it("should return the correct cell for indexPath") {
                        let cell = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))
                        expect(cell.accessibilityIdentifier) == "TEST CELL"
                    }

                    it("should return the correct header for section") {
                        let header = sut.tableView(UITableView(), viewForHeaderInSection: 0)
                        expect(header?.accessibilityIdentifier) == "TEST HEADER"
                    }

                    it("should return the correct height for header in section") {
                        let height = sut.tableView(UITableView(), heightForHeaderInSection: 0)
                        expect(height) == 33.3
                    }
                }
            }
        }
    }
}
