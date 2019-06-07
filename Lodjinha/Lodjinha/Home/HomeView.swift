//
//  HomeView.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class HomeView: UIView {

    typealias TableViewDelegateDataSource = UITableViewDelegate & UITableViewDataSource

    private lazy var tableView: UITableView = {
        let table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.tableFooterView = UIView()
        table.separatorStyle = .none

        table.register(cellType: BannerTableViewCell.self)
        table.register(cellType: CategoriesTableViewCell.self)

        return table
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(delegateSource: TableViewDelegateDataSource, frame: CGRect = .zero) {
        super.init(frame: frame)
        tableView.delegate = delegateSource
        tableView.dataSource = delegateSource
        setupView()
    }

    // MARK: - TableView updates

    func reloadTableViewSections(at sections: IndexSet) {
        tableView.beginUpdates()
        tableView.reloadSections(sections, with: .fade)
        tableView.endUpdates()
    }
}

// MARK: - ViewConfiguration

extension HomeView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.anchorTo(view: self)
    }

    func configureViews() {
        backgroundColor = UIColor.White
    }
}
