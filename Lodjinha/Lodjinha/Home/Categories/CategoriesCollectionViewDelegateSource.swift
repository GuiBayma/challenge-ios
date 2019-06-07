//
//  CategoriesCollectionViewDelegateSource.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class CategoriesCollectionViewDelegateSource: NSObject {

    private var categories: [Category] = []

    func setCategories(_ categories: [Category]) {
        self.categories = categories
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesCollectionViewDelegateSource: UICollectionViewDelegateFlowLayout {
}

// MARK: - UICollectionViewDataSource

extension CategoriesCollectionViewDelegateSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categories.count
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CategoriesCollectionViewCell
        return cell
    }
}
