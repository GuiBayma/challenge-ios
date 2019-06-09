//
//  BannerCollectionViewDelegateSourceSpec.swift
//  LodjinhaTests
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Nimble
import Quick
import UIKit
@testable import Lodjinha

class BannerCollectionViewDelegateSourceSpec: QuickSpec {

    override func spec() {
        describe("BannerCollectionViewDelegateSource") {
            var sut: BannerCollectionViewDelegateSource!
            var collectionView: UICollectionView!

            beforeEach {
                sut = BannerCollectionViewDelegateSource()
                collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
                collectionView.register(cellType: BannerCollectionViewCell.self)
                let path = Bundle(for: BannerAPIMock.self).path(forResource: "Banner_test", ofType: "png")
                let image = UIImage(contentsOfFile: path!)
                let banner = Banner(id: 0, image: image)
                sut.setBanners([banner])
            }

            context("UICollectionViewDelegateFlowLayout") {
                it("should return the correct minimum line spacing") {
                    let spacing = sut.collectionView(collectionView, layout: UICollectionViewLayout(), minimumLineSpacingForSectionAt: 0)
                    expect(spacing) == 0
                }
            }

            context("UICollectionViewDataSource") {
                it("should return the correct cell") {
                    let cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
                    expect(cell).to(beAKindOf(BannerCollectionViewCell.self))
                }
            }
        }
    }
}
