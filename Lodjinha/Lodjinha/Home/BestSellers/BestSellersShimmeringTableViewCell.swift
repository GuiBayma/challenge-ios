//
//  BestSellersShimmeringTableViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Reusable
import UIKit

final class BestSellersShimmeringTableViewCell: UITableViewCell, Reusable {

    private lazy var shinyImage: ShimmerView = {
        let view: ShimmerView = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var shinyDescription: ShimmerView = {
        let view: ShimmerView = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var shinyOldPrice: ShimmerView = {
        let view: ShimmerView = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var shinyCurrentPrice: ShimmerView = {
        let view: ShimmerView = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var separator: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.LightGray
        return view
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
}

// MARK: - ViewConfiguration

extension BestSellersShimmeringTableViewCell: ViewConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(shinyImage)
        contentView.addSubview(shinyDescription)
        contentView.addSubview(shinyOldPrice)
        contentView.addSubview(shinyCurrentPrice)
        contentView.addSubview(separator)
    }

    func setupConstraints() {
        let margin: CGFloat = 15

        shinyImage
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: margin)
            .topAnchor(equalTo: contentView.topAnchor, constant: margin)
            .bottomAnchor(equalTo: separator.topAnchor, constant: -margin)
            .heightAnchor(equalTo: 90)
            .widthAnchor(equalTo: 90)

        shinyDescription
            .leadingAnchor(equalTo: shinyImage.trailingAnchor, constant: 5)
            .topAnchor(equalTo: shinyImage.topAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -margin)
            .heightAnchor(equalTo: 50)

        shinyOldPrice
            .leadingAnchor(equalTo: shinyDescription.leadingAnchor, constant: margin)
            .centerYAnchor(equalTo: shinyCurrentPrice.centerYAnchor)
            .heightAnchor(equalTo: 20)
            .widthAnchor(equalTo: 60)

        shinyCurrentPrice
            .trailingAnchor(equalTo: shinyDescription.trailingAnchor)
            .bottomAnchor(equalTo: shinyImage.bottomAnchor)
            .heightAnchor(equalTo: 30)
            .widthAnchor(equalTo: 90)

        separator
            .leadingAnchor(equalTo: shinyImage.leadingAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor, constant: 1)
            .heightAnchor(equalTo: 1)
    }

    func configureViews() {
        backgroundColor = UIColor.White
        selectionStyle = .none
    }
}
