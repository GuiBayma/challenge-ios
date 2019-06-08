//
//  BestSellersTableViewHandler.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class BestSellersTableViewHandler {
    weak var delegate: TableViewHandlerActionDelegate?
    private let apiService: BestSellersApiProtocol
    private let section: Int
    private var bestSellers: [BestSeller] = []

    init(section: Int, apiService: BestSellersApiProtocol = BestSellersAPI()) {
        self.section = section
        self.apiService = apiService
        fetchBestSellers()
    }

    private func fetchBestSellers() {
        apiService.getBestSellers { [weak self] result in
            switch result {
            case let .success(response):
                self?.bestSellers = response.data.map {
                    BestSeller(name: $0.nome,
                               imageUrlString: $0.urlImagem,
                               image: nil,
                               oldPrice: $0.precoDe,
                               currentPrice: $0.precoPor)
                }
                self?.delegate?.updateTableView(section: self?.section ?? 0)
            case .failure:
                break
            }
        }
    }
}

// MARK: - TableViewHandlerDelegate

extension BestSellersTableViewHandler: TableViewHandlerDelegate {
    func numberOfRowsInSection(_ section: Int) -> Int {
        if bestSellers.isEmpty {
            return 1
        }
        return bestSellers.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return BestSellersSectionHeaderView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if bestSellers.isEmpty {
            let cell = tableView.dequeueReusableCell(for: indexPath) as BestSellersShimmeringTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath) as BestSellerTableViewCell
            cell.delegate = self
            cell.index = indexPath.row
            if bestSellers.indices.contains(indexPath.row) {
                let bestSeller: BestSeller = bestSellers[indexPath.item]
                cell.setBestSeller(bestSeller)
            }
            return cell
        }
    }
}

// MARK: - BestSellerTableViewCellDelegate

extension BestSellersTableViewHandler: BestSellerTableViewCellDelegate {
    func bestSellerTableViewCell(_ cell: BestSellerTableViewCell, getImage urlString: String) {
        apiService.getBestSellerImage(imageUrl: urlString) { [weak self] result in
            var image: UIImage = Asset.placeholderImage.image
            switch result {
            case let .success(response):
                image = response
            case .failure:
                break
            }
            self?.bestSellers[cell.index].image = image
            self?.delegate?.updateTableView(section: self?.section ?? 0, row: cell.index)
        }
    }
}
