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
    private let apiService: CategoriesApiProtocol
    private let section: Int

    init(section: Int, apiService: CategoriesApiProtocol = CategoriesAPI()) {
        self.section = section
        self.apiService = apiService
        fetchBestSellers()
    }

    private func fetchBestSellers() {
    }
}

// MARK: - TableViewHandlerDelegate

extension BestSellersTableViewHandler: TableViewHandlerDelegate {
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return BestSellersSectionHeaderView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as BestSellersShimmeringTableViewCell
        return cell
    }
}
