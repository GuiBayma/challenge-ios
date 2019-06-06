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

    private lazy var runnerView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.opacity = 0.6
        return view
    }()

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
        gradientLayer.frame = runnerView.bounds
        gradientLayer.colors = [UIColor.Background.LightGray.cgColor,
                                UIColor.Background.DarkGray.cgColor,
                                UIColor.Background.LightGray.cgColor]
        gradientLayer.locations = [0, 0.5, 1]

        runnerView.layer.addSublayer(gradientLayer)
    }

    private func animate() {
        runnerView.layer.removeAllAnimations()

        guard let view = superview else { return }

        let positionAnimation: CABasicAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.beginTime = 0.5
        positionAnimation.fromValue = runnerView.layer.position
        positionAnimation.toValue = CGPoint(x: view.convert(layer.position, to: self).x + frame.width,
                                            y: runnerView.layer.position.y)
        positionAnimation.duration = 1
        positionAnimation.repeatCount = .infinity
        positionAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        runnerView.layer.add(positionAnimation, forKey: positionAnimation.keyPath)
    }
}

// MARK: - ViewConfiguration

extension ShimmerView: ViewConfiguration {
    func setupViewHierarchy() {
        addSubview(runnerView)
    }

    func setupConstraints() {
        runnerView.anchorTo(view: self)
    }

    func configureViews() {
        backgroundColor = UIColor.Background.LightGray
        clipsToBounds = true
    }
}
