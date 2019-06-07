//
//  CategoriesCollectionViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Reusable
import UIKit

protocol CategoriesCollectionViewCellDelegate: AnyObject {
    func categoriesCollectionViewCell(_ cell: CategoriesCollectionViewCell, getImage urlString: String)
}

final class CategoriesCollectionViewCell: UICollectionViewCell, Reusable {

    weak var delegate: CategoriesCollectionViewCellDelegate?
    var index: Int = 0

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
        label.textColor = UIColor.DarkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "PLACEHOLDER\nTEXT"
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

    func setCategory(description: String, imageUrl: String, image: UIImage?) {
        setDescription(description)
        if let image = image {
            setImage(image)
        } else {
            delegate?.categoriesCollectionViewCell(self, getImage: imageUrl)
        }
    }

    private func setImage(_ image: UIImage) {
        imageView.setImage(image, targetSize: CGSize(width: 80, height: 80))
        contentView.bringSubviewToFront(imageView)
        shimmeringImageView.stopAnimation()
        shimmeringImageView.removeFromSuperview()
    }

    private func setDescription(_ description: String) {
        descriptionLabel.text = description
        contentView.bringSubviewToFront(descriptionLabel)
        shimmeringLabelView.stopAnimation()
        shimmeringLabelView.removeFromSuperview()
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

        imageView
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: margin)
            .topAnchor(equalTo: contentView.topAnchor, constant: margin)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -margin)

        shimmeringImageView.anchorTo(view: imageView)

        descriptionLabel
            .leadingAnchor(equalTo: imageView.leadingAnchor)
            .topAnchor(equalTo: imageView.bottomAnchor, constant: margin)
            .trailingAnchor(equalTo: imageView.trailingAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor, constant: -margin)

        shimmeringLabelView.anchorTo(view: descriptionLabel)
    }

    func configureViews() {
        contentView.bringSubviewToFront(shimmeringImageView)
        contentView.bringSubviewToFront(shimmeringLabelView)
    }
}
