//
//  ShimmerView.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class ShimmerView: UIView {

    private let gradientLayer: CAGradientLayer = CAGradientLayer()

    private lazy var shinyView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.White
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

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        configureGradientLayer()
        DispatchQueue.main.async {
            self.animate()
        }
    }

    private func configureGradientLayer() {
        gradientLayer.frame = shinyView.frame
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.White.cgColor,
                                UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        let angle: CGFloat = 90 * .pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)

        shinyView.layer.mask = gradientLayer
    }

    private func animate() {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -shinyView.frame.width
        animation.toValue = shinyView.frame.width
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}

// MARK: - ViewConfiguration

extension ShimmerView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(shinyView)
    }

    func setupConstraints() {
        shinyView.anchorTo(view: self)
    }

    func configureViews() {
        backgroundColor = UIColor.Gray
        clipsToBounds = true
    }
}
