//
//  AboutView.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 04/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class AboutView: UIView {

    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = Asset.logoSobre.image
        return view
    }()

    private lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(font: FontFamily.Pacifico.regular, size: 48.0)
        label.textColor = UIColor.Text.Grey
        label.textAlignment = .center
        label.text = L10n.brandName
        return label
    }()

    private lazy var developerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor.Text.Grey
        label.textAlignment = .center
        label.text = L10n.developerName
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor.Text.Grey
        label.textAlignment = .center
        label.text = L10n.developmentDate
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
}

// MARK: - ViewConfiguration

extension AboutView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(logoImageView)
        addSubview(brandLabel)
        addSubview(developerLabel)
        addSubview(dateLabel)
    }

    func setupConstraints() {
        let margin: CGFloat = 15

        logoImageView
            .centerXAnchor(equalTo: centerXAnchor)
            .heightAnchor(equalTo: heightAnchor, multiplier: 0.25)
            .widthAnchor(equalTo: logoImageView.heightAnchor)
            .bottomAnchor(equalTo: brandLabel.topAnchor, constant: -margin)

        brandLabel
            .centerYAnchor(equalTo: centerYAnchor)
            .leadingAnchor(equalTo: leadingAnchor, constant: margin)
            .trailingAnchor(equalTo: trailingAnchor, constant: -margin)

        developerLabel
            .leadingAnchor(equalTo: brandLabel.leadingAnchor)
            .trailingAnchor(equalTo: brandLabel.trailingAnchor)
            .bottomAnchor(equalTo: dateLabel.topAnchor, constant: -8)

        dateLabel
            .leadingAnchor(equalTo: brandLabel.leadingAnchor)
            .trailingAnchor(equalTo: brandLabel.trailingAnchor)

        if #available(iOS 11.0, *) {
            dateLabel
                .bottomAnchor(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        } else {
            dateLabel
                .bottomAnchor(equalTo: bottomAnchor, constant: -margin - 44)
        }
    }

    func configureViews() {
        backgroundColor = .white
    }
}
