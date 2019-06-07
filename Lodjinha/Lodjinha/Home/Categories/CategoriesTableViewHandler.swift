//
//  CategoriesTableViewHandler.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol CategoriesTableViewHandlerDelegate: AnyObject {
    func updateCollectionView(at item: Int)
}

final class CategoriesTableViewHandler {
    weak var delegate: TableViewHandlerActionDelegate?
    private weak var collectionDelegate: CategoriesTableViewHandlerDelegate?
    private let apiService: CategoriesApiProtocol
    private let section: Int
    private lazy var categoriesCollectionDelegateSource = CategoriesCollectionViewDelegateSource(cellDelegate: self)

    init(section: Int, apiService: CategoriesApiProtocol = CategoriesAPI()) {
        self.section = section
        self.apiService = apiService
        fetchCategories()
    }

    private func fetchCategories() {
        apiService.getCategories { [weak self] result in
            switch result {
            case let .success(response):
                let responseCategories: [CategoriesResponse] = response.data
                let categories: [Category] = responseCategories.map {
                    Category(description: $0.descricao, imageUrlString: $0.urlImagem, image: nil)
                }
                self?.categoriesCollectionDelegateSource.setCategories(categories)
                self?.delegate?.updateTableView(section: self?.section ?? 0)
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: - TableViewHandlerDelegate

extension CategoriesTableViewHandler: TableViewHandlerDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CategoriesTableViewCell
        cell.setCollectionViewDelegateDataSource(categoriesCollectionDelegateSource)
        collectionDelegate = cell
        return cell
    }
}

// MARK: - CategoriesCollectionViewCellDelegate

extension CategoriesTableViewHandler: CategoriesCollectionViewCellDelegate {
    func categoriesCollectionViewCell(_ cell: CategoriesCollectionViewCell, getImage urlString: String) {
        apiService.getCategoryImage(imageUrl: urlString) { [weak self] result in
            var image: UIImage = Asset.categoryPlaceholderImage.image
            switch result {
            case let .success(response):
                image = response
            case .failure:
                break
            }
            self?.categoriesCollectionDelegateSource.updateCategory(with: image, at: cell.index)
            self?.collectionDelegate?.updateCollectionView(at: cell.index)
        }
    }
}
