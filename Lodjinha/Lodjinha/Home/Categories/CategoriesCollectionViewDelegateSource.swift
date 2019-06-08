//
//  CategoriesCollectionViewDelegateSource.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class CategoriesCollectionViewDelegateSource: NSObject {

    weak var delegate: TableViewHandlerActionDelegate?
    weak var cellDelegate: CategoriesCollectionViewCellDelegate?
    private var categories: [Category] = []

    init(cellDelegate: CategoriesCollectionViewCellDelegate) {
        self.cellDelegate = cellDelegate
    }

    func setCategories(_ categories: [Category]) {
        self.categories = categories
    }

    func updateCategory(with image: UIImage, at index: Int) {
        categories[index].image = image
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesCollectionViewDelegateSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category: Category = categories[indexPath.row]
        delegate?.didSelectCollectionItem(category: category)
    }
}

// MARK: - UICollectionViewDataSource

extension CategoriesCollectionViewDelegateSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories.isEmpty {
            return 3
        }
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CategoriesCollectionViewCell
        cell.delegate = cellDelegate
        cell.index = indexPath.item
        if categories.indices.contains(indexPath.item) {
            let category: Category = categories[indexPath.item]
            cell.setCategory(description: category.description, imageUrl: category.imageUrlString, image: category.image)
        }
        return cell
    }
}
