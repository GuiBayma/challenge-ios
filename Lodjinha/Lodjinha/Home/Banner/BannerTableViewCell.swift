//
//  BannerTableViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import Reusable
import UIKit

final class BannerTableViewCell: UITableViewCell, Reusable {

    var banners: [Banner]? {
        didSet {
            guard !(banners?.isEmpty ?? true) else { return }
            // Set page view
        }
    }

    private lazy var shimmeringView: ShimmerView = {
        let view = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
}

// MARK: - ViewConfiguration

extension BannerTableViewCell: ViewConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(shimmeringView)
    }

    func setupConstraints() {
        shimmeringView
            .anchorTo(view: contentView, inset: 5)
            .heightAnchor(equalTo: 120)
    }

    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
