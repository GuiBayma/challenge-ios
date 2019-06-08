//
//  ProductDetailView.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class ProductDetailView: UIView {

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 10
        return view
    }()

    private let productHeaderView: ProductHeaderView = ProductHeaderView()
    private let productPriceView: ProductPriceView = ProductPriceView()
    private let productDescriptionView: ProductDescriptionView = ProductDescriptionView()

    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.LightGray
        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.reserveButtonTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.Purple
        button.layer.cornerRadius = 10
        return button
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    // MARK: - Set product

    func setProduct(_ product: Product) {
        productHeaderView.setImage(product.image)
        productHeaderView.setSubtitleLabel(product.name)
        productPriceView.setOldPrice(product.oldPrice)
        productPriceView.setCurrentPrice(product.currentPrice)
        productDescriptionView.setCategory(product.categoryName)
        productDescriptionView.setDescription(product.description)
    }
}

// MARK: - ViewConfiguration

extension ProductDetailView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(productHeaderView)
        stackView.addArrangedSubview(productPriceView)
        stackView.addArrangedSubview(productDescriptionView)
        addSubview(separator)
        addSubview(button)
    }

    func setupConstraints() {
        let margin: CGFloat = 10

        scrollView
            .leadingAnchor(equalTo: leadingAnchor)
            .trailingAnchor(equalTo: trailingAnchor)
            .bottomAnchor(equalTo: separator.topAnchor)

        if #available(iOS 11.0, *) {
            scrollView.topAnchor(equalTo: safeAreaLayoutGuide.topAnchor)
        } else {
            scrollView.topAnchor(equalTo: topAnchor)
        }

        stackView
            .leadingAnchor(equalTo: scrollView.leadingAnchor)
            .topAnchor(equalTo: scrollView.topAnchor)
            .trailingAnchor(equalTo: scrollView.trailingAnchor)
            .bottomAnchor(equalTo: scrollView.bottomAnchor)
            .widthAnchor(equalTo: widthAnchor)

        separator
            .leadingAnchor(equalTo: leadingAnchor)
            .trailingAnchor(equalTo: trailingAnchor)
            .heightAnchor(equalTo: 1)

        button
            .leadingAnchor(equalTo: leadingAnchor, constant: margin)
            .topAnchor(equalTo: separator.bottomAnchor, constant: margin)
            .trailingAnchor(equalTo: trailingAnchor, constant: -margin)
            .heightAnchor(equalTo: 50)

        if #available(iOS 11.0, *) {
            button.bottomAnchor(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        } else {
            button.bottomAnchor(equalTo: bottomAnchor, constant: -margin)
        }
    }

    func configureViews() {
        backgroundColor = .white
    }
}
