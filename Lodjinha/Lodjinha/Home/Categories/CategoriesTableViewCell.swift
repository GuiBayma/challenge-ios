//
//  CategoriesTableViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Reusable
import UIKit

final class CategoriesTableViewCell: UITableViewCell, Reusable {

    typealias CollectionViewDelegateDataSource = UICollectionViewDelegateFlowLayout & UICollectionViewDataSource

    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.DarkGray
        label.text = L10n.categoriesSectionTitle
        return label
    }()

    private lazy var separator: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.LightGray
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 1, height: 1)

        let collection: UICollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(cellType: CategoriesCollectionViewCell.self)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor.White
        return collection
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    // MARK: - Set CollectionViewDelegateDataSource

    func setCollectionViewDelegateDataSource(_ source: CollectionViewDelegateDataSource) {
        collectionView.delegate = source
        collectionView.dataSource = source
    }
}

// MARK: - ViewConfiguration

extension CategoriesTableViewCell: ViewConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(separator)
        contentView.addSubview(collectionView)
    }

    func setupConstraints() {
        let margin: CGFloat = 15

        titleLabel
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: margin)
            .topAnchor(equalTo: contentView.topAnchor, constant: margin)

        separator
            .leadingAnchor(equalTo: contentView.leadingAnchor)
            .topAnchor(equalTo: titleLabel.bottomAnchor, constant: 2)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .heightAnchor(equalTo: 1)

        collectionView
            .leadingAnchor(equalTo: contentView.leadingAnchor)
            .topAnchor(equalTo: separator.bottomAnchor, constant: 2)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .heightAnchor(equalTo: 150)
    }

    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
