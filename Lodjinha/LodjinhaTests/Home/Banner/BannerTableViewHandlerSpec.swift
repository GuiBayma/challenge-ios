//
//  BannerTableViewHandlerSpec.swift
//  LodjinhaTests
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Nimble
import Quick
import UIKit
@testable import Lodjinha

class BannerAPIMock: BannerApiProtocol {
    func getBanners(completion: @escaping (Result<BannerData, NetworkError>) -> Void) {
        completion(.success(BannerData(data: [BannerResponse(id: 0, urlImagem: "URL_IMAGE_TEST", linkUrl: "URL_LINK_TEST")])))
    }

    func getBannerImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let path = Bundle(for: BannerAPIMock.self).path(forResource: "Banner_test", ofType: "png")
        let image = UIImage(contentsOfFile: path!)
        completion(.success(image!))
    }
}

class TableViewHandlerActionDelegateMock: TableViewHandlerActionDelegate {
    var section: Int?
    func updateTableView(section: Int) {
        self.section = section
    }

    var row: Int?
    func updateTableView(section: Int, row: Int) {
        self.section = section
        self.row = row
    }

    var category: Lodjinha.Category?
    func didSelectCollectionItem(category: Lodjinha.Category) {
        self.category = category
    }
}

class BannerTableViewHandlerSpec: QuickSpec {

    override func spec() {
        describe("BannerTableViewHandler") {
            var sut: BannerTableViewHandler!
            var apiMock: BannerAPIMock!
            var actionDelegateMock: TableViewHandlerActionDelegateMock!

            beforeEach {
                apiMock = BannerAPIMock()
                actionDelegateMock = TableViewHandlerActionDelegateMock()
                sut = BannerTableViewHandler(section: 0, apiService: apiMock)
                sut.delegate = actionDelegateMock
            }

            context("TableViewHandlerDelegate") {
                it("should conform to TableViewHandlerDelegate") {
                    expect(sut).to(beAKindOf(TableViewHandlerDelegate.self))
                }

                it("should return the correct cell for index path") {
                    let tableView = UITableView()
                    tableView.register(cellType: BannerTableViewCell.self)
                    let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                    expect(cell).to(beAKindOf(BannerTableViewCell.self))
                }
            }

            context("TableViewHandlerActionDelegate") {
                xit("should call delegate after loading banners") {
                    expect(actionDelegateMock.section).toEventually(equal(0))
                }
            }
        }
    }
}
