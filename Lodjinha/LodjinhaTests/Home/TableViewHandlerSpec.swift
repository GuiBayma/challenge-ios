//
//  TableViewHandlerSpec.swift
//  LodjinhaTests
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Nimble
import Quick
import UIKit
@testable import Lodjinha

class TableViewHandlerSpec: QuickSpec {

    override func spec() {
        describe("TableViewHandler") {
            var sut: TableViewHandler!

            beforeEach {
                let child1 = TableViewHandlerMock()
                let child2 = TableViewHandlerMock()
                let child3 = TableViewHandlerMock()
                sut = TableViewHandler(childHandlers: [child1, child2, child3])
            }

            context("TableViewHandlerDelegate") {
                it("should have the correct number of sections") {
                    let sections = sut.numberOfSections()
                    expect(sections) == 3
                }

                it("should return the correct number of rows for section") {
                    let rows = sut.numberOfRowsInSection(0)
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

                it("should return a Product") {
                    let product = sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
                    expect(product?.name) == "PRODUCT TEST NAME"
                }
            }
        }
    }
}
