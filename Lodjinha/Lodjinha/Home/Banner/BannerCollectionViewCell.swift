//
//  BannerCollectionViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 06/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Reusable
import UIKit

final class BannerCollectionViewCell: UICollectionViewCell, Reusable {

    private lazy var imageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    // MARK: - Set image

    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}

// MARK: - ViewConfiguration

extension BannerCollectionViewCell: ViewConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(imageView)
    }

    func setupConstraints() {
        imageView.anchorTo(view: contentView)
    }
}
