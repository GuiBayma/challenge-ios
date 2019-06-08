//
//  ProductsListTableViewDelegateSource.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol ProductsListDelegateSourceProtocol: TableViewDelegateDataSource {
    var delegate: ProductsListDelegateSourceDelegate? { get set }
    var cellDelegate: BestSellerTableViewCellDelegate? { get set }
    func updateProducts(_ newProducts: [Product])
    func updateProduct(with image: UIImage, at index: Int)
}

protocol ProductsListDelegateSourceDelegate: AnyObject {
    func shouldLoadMoreProducts()
    func didSelectProduct(product: Product)
}

final class ProductsListTableViewDelegateSource: NSObject {
    weak var delegate: ProductsListDelegateSourceDelegate?
    weak var cellDelegate: BestSellerTableViewCellDelegate?
    private var products: [Product] = []
    private let loadBefore: Int = 10
}

// MARK: - ProductsListDelegateSource

extension ProductsListTableViewDelegateSource: ProductsListDelegateSourceProtocol {
    func updateProducts(_ newProducts: [Product]) {
        products.append(contentsOf: newProducts)
    }

    func updateProduct(with image: UIImage, at index: Int) {
        products[index].image = image
    }
}

// MARK: - UITableViewDelegate

extension ProductsListTableViewDelegateSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > products.count - loadBefore {
            delegate?.shouldLoadMoreProducts()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product: Product = products[indexPath.row]
        delegate?.didSelectProduct(product: product)
    }
}

// MARK: - UITableViewDataSource

extension ProductsListTableViewDelegateSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products.isEmpty {
            return 2
        }
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if products.isEmpty {
            let cell = tableView.dequeueReusableCell(for: indexPath) as BestSellersShimmeringTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath) as BestSellerTableViewCell
            cell.index = indexPath.row
            cell.delegate = cellDelegate
            if products.indices.contains(indexPath.row) {
                let product: Product = products[indexPath.item]
                cell.setBestSeller(product)
            }
            return cell
        }
    }
}
