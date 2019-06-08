//
//  BestSellerTableViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Reusable
import UIKit

protocol BestSellerTableViewCellDelegate: AnyObject {
    func bestSellerTableViewCell(_ cell: BestSellerTableViewCell, getImage urlString: String)
}

final class BestSellerTableViewCell: UITableViewCell, Reusable {

    weak var delegate: BestSellerTableViewCellDelegate?
    var index: Int = 0

    private lazy var productImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = UIView.ContentMode.scaleAspectFit
        return image
    }()

    private lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor.DarkGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var oldPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = UIColor.Gray2
        return label
    }()

    private lazy var currentPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.Orange
        return label
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

    // MARK: - Setters

    func setBestSeller(_ bestSeller: Product) {
        descriptionLabel.text = "\(bestSeller.name)"
        setOldPrice(bestSeller.oldPrice)
        currentPriceLabel.text = L10n.currentPriceLabel(String(format: "%.2f", bestSeller.currentPrice))
        if let image = bestSeller.image {
            productImage.setImage(image, targetSize: CGSize(width: 90, height: 90))
        } else {
            productImage.image = Asset.placeholderImage.image
            delegate?.bestSellerTableViewCell(self, getImage: bestSeller.imageUrlString)
        }
    }

    private func setOldPrice(_ price: Float) {
        let formattedString: String = L10n.oldPriceLabel(String(format: "%.2f", price))
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
        attributeString.addAttribute(.strikethroughStyle,
                                     value: 2,
                                     range: NSRange(location: 0, length: attributeString.length))
        oldPriceLabel.attributedText = attributeString
    }
}

// MARK: - ViewConfiguration

extension BestSellerTableViewCell: ViewConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(productImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(oldPriceLabel)
        contentView.addSubview(currentPriceLabel)
        contentView.addSubview(separator)
    }

    func setupConstraints() {
        let margin: CGFloat = 15

        productImage
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: margin)
            .topAnchor(equalTo: contentView.topAnchor, constant: margin)
            .bottomAnchor(equalTo: separator.topAnchor, constant: -margin)

        descriptionLabel
            .leadingAnchor(equalTo: productImage.trailingAnchor, constant: 5)
            .topAnchor(equalTo: productImage.topAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -margin)

        oldPriceLabel
            .leadingAnchor(equalTo: descriptionLabel.leadingAnchor)
            .centerYAnchor(equalTo: currentPriceLabel.centerYAnchor)

        currentPriceLabel
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .bottomAnchor(equalTo: productImage.bottomAnchor)

        separator
            .leadingAnchor(equalTo: productImage.leadingAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor, constant: 1)
            .heightAnchor(equalTo: 1)
    }

    func configureViews() {
        backgroundColor = UIColor.White
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
}
