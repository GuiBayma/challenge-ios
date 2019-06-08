//
//  ProductsListTableViewDelegateSource.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class ProductsListTableViewDelegateSource: NSObject {

}

// MARK: - UITableViewDelegate

extension ProductsListTableViewDelegateSource: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension ProductsListTableViewDelegateSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as BestSellersShimmeringTableViewCell
        return cell
    }
}
