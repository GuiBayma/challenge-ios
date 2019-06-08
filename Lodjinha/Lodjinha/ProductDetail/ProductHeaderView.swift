//
//  ProductHeaderView.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class ProductHeaderView: UIView {

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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

    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

    func setSubtitleLabel(_ text: String) {
        subtitleLabel.text = text
    }
}

// MARK: - ViewConfiguration

extension ProductHeaderView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(imageView)
        addSubview(subtitleLabel)
    }

    func setupConstraints() {
        let margin: CGFloat = 20

        imageView
            .topAnchor(equalTo: topAnchor, constant: margin)
            .centerXAnchor(equalTo: centerXAnchor)
            .widthAnchor(lessThanOrEqualTo: widthAnchor)
            .heightAnchor(lessThanOrEqualTo: widthAnchor)

        subtitleLabel
            .leadingAnchor(equalTo: leadingAnchor, constant: margin)
            .topAnchor(equalTo: imageView.bottomAnchor, constant: margin)
            .trailingAnchor(equalTo: trailingAnchor, constant: -margin)
            .bottomAnchor(equalTo: bottomAnchor, constant: -margin)
    }

    func configureViews() {
        backgroundColor = .white
    }
}
