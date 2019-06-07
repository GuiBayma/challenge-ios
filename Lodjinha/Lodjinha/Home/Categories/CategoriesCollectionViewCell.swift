//
//  CategoriesCollectionViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Reusable
import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell, Reusable {

    private lazy var shimmeringImageView: ShimmerView = {
        let view = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var imageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var shimmeringLabelView: ShimmerView = {
        let view = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor.Text.Gray
        label.textAlignment = .center
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    // MARK: - Setters

    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

    func setDescription(_ text: String) {
        descriptionLabel.text = text
    }
}

// MARK: - ViewConfiguration

extension CategoriesCollectionViewCell: ViewConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(shimmeringImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(shimmeringLabelView)
    }

    func setupConstraints() {
        let margin: CGFloat = 5

        shimmeringImageView
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: margin)
            .topAnchor(equalTo: contentView.topAnchor, constant: margin)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -margin)
            .heightAnchor(equalTo: 80)
            .widthAnchor(equalTo: 80)

        shimmeringLabelView
            .leadingAnchor(equalTo: shimmeringImageView.leadingAnchor)
            .topAnchor(equalTo: shimmeringImageView.bottomAnchor, constant: margin)
            .trailingAnchor(equalTo: shimmeringImageView.trailingAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor, constant: -margin)
            .heightAnchor(equalTo: 30)
    }
}
