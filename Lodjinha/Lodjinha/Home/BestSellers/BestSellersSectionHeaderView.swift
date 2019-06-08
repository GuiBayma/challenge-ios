//
//  BestSellersSectionHeaderView.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class BestSellersSectionHeaderView: UIView {

    private lazy var separator: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.LightGray
        return view
    }()

    private lazy var headerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.DarkGray
        label.text = L10n.bestSellersSectionTitle
        return label
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
}

// MARK: - ViewConfiguration

extension BestSellersSectionHeaderView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(separator)
        addSubview(headerLabel)
    }

    func setupConstraints() {
        let margin: CGFloat = 15

        separator
            .leadingAnchor(equalTo: leadingAnchor)
            .topAnchor(equalTo: topAnchor)
            .trailingAnchor(equalTo: trailingAnchor)
            .heightAnchor(equalTo: 1)

        headerLabel
            .leadingAnchor(equalTo: leadingAnchor, constant: margin)
            .topAnchor(equalTo: separator.bottomAnchor, constant: margin)
            .trailingAnchor(equalTo: trailingAnchor)
            .bottomAnchor(equalTo: bottomAnchor, constant: -margin)
    }

    func configureViews() {
        backgroundColor = UIColor.White
    }
}
