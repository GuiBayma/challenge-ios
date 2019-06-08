//
//  ProductDescriptionView.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class ProductDescriptionView: UIView {

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.DarkGray
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textColor = UIColor.DarkGray
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

    // MARK: - Setters

    func setCategory(_ categoryName: String) {
        categoryLabel.text = L10n.categoryTitleLabel(categoryName)
    }

    func setDescription(_ text: String) {
        descriptionLabel.text = text.replacingOccurrences(of: "<br/>", with: "\n")
    }
}

// MARK: - ViewConfiguration

extension ProductDescriptionView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(categoryLabel)
        addSubview(descriptionLabel)
    }

    func setupConstraints() {
        let margin: CGFloat = 20

        categoryLabel
            .leadingAnchor(equalTo: leadingAnchor, constant: margin)
            .topAnchor(equalTo: topAnchor, constant: margin)
            .trailingAnchor(equalTo: trailingAnchor, constant: -margin)

        descriptionLabel
            .leadingAnchor(equalTo: categoryLabel.leadingAnchor)
            .topAnchor(equalTo: categoryLabel.bottomAnchor, constant: margin)
            .trailingAnchor(equalTo: categoryLabel.trailingAnchor)
            .bottomAnchor(equalTo: bottomAnchor, constant: -margin)
    }

    func configureViews() {
        backgroundColor = .white
    }
}
