//
//  BannerTableViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Reusable
import UIKit

final class BannerTableViewCell: UITableViewCell, Reusable {

    typealias CollectionViewDelegateDataSource = UICollectionViewDelegateFlowLayout & UICollectionViewDataSource

    private lazy var shimmeringView: ShimmerView = {
        let view = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 1, height: 1)

        let collection: UICollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(cellType: BannerCollectionViewCell.self)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
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

    // MARK: - Show collection view

    func updateCollectionView() {
        shimmeringView.stopAnimation()
        shimmeringView.removeFromSuperview()
        contentView.addSubview(collectionView)
        collectionView
            .anchorTo(view: contentView)
            .heightAnchor(equalTo: UIScreen.main.bounds.width * 0.25)
    }
}

// MARK: - ViewConfiguration

extension BannerTableViewCell: ViewConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(shimmeringView)
    }

    func setupConstraints() {
        shimmeringView
            .anchorTo(view: contentView, inset: 5)
            .heightAnchor(equalTo: 120)
    }

    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
