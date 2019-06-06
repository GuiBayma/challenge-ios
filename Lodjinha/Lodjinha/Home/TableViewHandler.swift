//
//  TableViewHandler.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol TableViewHandlerDelegate: AnyObject {
    func numberOfRowsInSection(_ section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

final class TableViewHandler {

    private var childHandlers: [TableViewHandlerDelegate]

    init(childHandlers: [TableViewHandlerDelegate] = []) {
        self.childHandlers = childHandlers
        createChildHandlers()
    }

    private func createChildHandlers() {
        guard childHandlers.isEmpty else { return }

        childHandlers.append(BannerTableViewHandler())
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
}
