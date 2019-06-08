//
//  ProductPriceView.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class ProductPriceView: UIView {

    private lazy var separatorTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.LightGray
        return view
    }()

    private lazy var oldPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textColor = UIColor.Gray2
        return label
    }()

    private lazy var currentPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor.Orange
        return label
    }()

    private lazy var separatorBottom: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.LightGray
        return view
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

    func setOldPrice(_ price: Float) {
        let formattedString: String = L10n.oldPriceLabel(String(format: "%.2f", price))
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
        attributeString.addAttribute(.strikethroughStyle,
                                     value: 2,
                                     range: NSRange(location: 0, length: attributeString.length))
        oldPrice.attributedText = attributeString
    }

    func setCurrentPrice(_ price: Float) {
        currentPrice.text = L10n.currentPriceLabel(String(format: "%.2f", price))
    }
}

// MARK: - ViewConfiguration

extension ProductPriceView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(separatorTop)
        addSubview(oldPrice)
        addSubview(currentPrice)
        addSubview(separatorBottom)
    }

    func setupConstraints() {
        let margin: CGFloat = 20

        separatorTop
            .leadingAnchor(equalTo: leadingAnchor)
            .topAnchor(equalTo: topAnchor)
            .trailingAnchor(equalTo: trailingAnchor)
            .widthAnchor(equalTo: UIScreen.main.bounds.width)
            .heightAnchor(equalTo: 1)

        oldPrice
            .centerYAnchor(equalTo: currentPrice.centerYAnchor)
            .leadingAnchor(equalTo: leadingAnchor, constant: margin)

        currentPrice
            .topAnchor(equalTo: separatorTop.bottomAnchor, constant: 10)
            .trailingAnchor(equalTo: trailingAnchor, constant: -margin)
            .bottomAnchor(equalTo: separatorBottom.topAnchor, constant: -10)

        separatorBottom
            .leadingAnchor(equalTo: separatorTop.leadingAnchor)
            .trailingAnchor(equalTo: separatorTop.trailingAnchor)
            .bottomAnchor(equalTo: bottomAnchor)
            .heightAnchor(equalTo: 1)
    }

    func configureViews() {
        backgroundColor = .white
    }
}
