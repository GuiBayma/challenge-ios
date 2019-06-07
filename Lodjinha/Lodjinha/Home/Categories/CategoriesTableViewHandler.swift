//
//  CategoriesTableViewHandler.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class CategoriesTableViewHandler {
    weak var delegate: TableViewHandlerActionDelegate?
    private let apiService: CategoriesApiProtocol
    private var isCellLoading: Bool = true
    private let categoriesCollectionDelegateSource: CategoriesCollectionViewDelegateSource

    init(apiService: CategoriesApiProtocol = CategoriesAPI(),
         categoriesCollectionDelegateSource: CategoriesCollectionViewDelegateSource = CategoriesCollectionViewDelegateSource()) {
        self.apiService = apiService
        self.categoriesCollectionDelegateSource = categoriesCollectionDelegateSource
        fetchCategories()
    }

    private func fetchCategories() {
    }
}

// MARK: - TableViewHandlerDelegate

extension CategoriesTableViewHandler: TableViewHandlerDelegate {
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CategoriesTableViewCell
        cell.setCollectionViewDelegateDataSource(categoriesCollectionDelegateSource)
        return cell
    }
}
