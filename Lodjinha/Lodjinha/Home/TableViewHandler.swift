//
//  TableViewHandler.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol TableViewHandlerDelegate: AnyObject {
    var delegate: TableViewHandlerActionDelegate? { get set }
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Product?
}

extension TableViewHandlerDelegate {
    func numberOfSections() -> Int { return 1 }
    func numberOfRowsInSection(_ section: Int) -> Int { return 1 }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Product? { return nil }
}

protocol TableViewHandlerActionDelegate: AnyObject {
    func updateTableView(section: Int)
    func updateTableView(section: Int, row: Int)
    func didSelectCollectionItem(category: Category)
}

final class TableViewHandler {

    weak var delegate: TableViewHandlerActionDelegate? {
        didSet {
            childHandlers.forEach { child in
                child.delegate = delegate
            }
        }
    }
    private var childHandlers: [TableViewHandlerDelegate]

    init(childHandlers: [TableViewHandlerDelegate] = []) {
        self.childHandlers = childHandlers
        createChildHandlers()
    }

    private func createChildHandlers() {
        guard childHandlers.isEmpty else { return }

        childHandlers.append(BannerTableViewHandler(section: 0))
        childHandlers.append(CategoriesTableViewHandler(section: 1))
        childHandlers.append(BestSellersTableViewHandler(section: 2))
    }
}

// MARK: - TableViewHandlerDelegate

extension TableViewHandler: TableViewHandlerDelegate {
    func numberOfSections() -> Int {
        return childHandlers.count
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return childHandlers[section].numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return childHandlers[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return childHandlers[section].tableView(tableView, viewForHeaderInSection: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return childHandlers[section].tableView(tableView, heightForHeaderInSection: section)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Product? {
        return childHandlers[indexPath.section].tableView(tableView, didSelectRowAt: indexPath)
    }
}
