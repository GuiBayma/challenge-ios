//
//  ProductDetailViewController.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 08/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol ProductDetailControllerNavigationDelegate: AnyObject {
    func didPressAlertAction(_ controller: ProductDetailViewController)
}

final class ProductDetailViewController: UIViewController {

    weak var navigationDelegate: ProductDetailControllerNavigationDelegate?
    private let productDetailView: ProductDetailView = ProductDetailView()
    private let product: Product
    private let apiService: ProductDetailApiProtocol

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(product: Product, apiService: ProductDetailApiProtocol = ProductDetailAPI()) {
        self.product = product
        self.apiService = apiService
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Controller lifecycle

    override func loadView() {
        self.view = productDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        productDetailView.delegate = self
        productDetailView.setProduct(product)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Navigation Bar setup

    private func setupNavigationBar() {
        navigationController?.configureNavigationBar(with: product.categoryName)
    }

    // MARK: - Alert

    private func showAlert(for responseType: ReservationResponseType) {
        var message: String = ""

        switch responseType {
        case .success:
            message = L10n.reserveAlertSuccessMessage(product.name)
        case .failure:
            message = L10n.reserveAlertFailureMessage
        }

        let alert: UIAlertController = UIAlertController(title: L10n.reserveAlertTitle,
                                                         message: message,
                                                         preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: L10n.reserveAlertButton,
                                                       style: .default,
                                                       handler: handleAlertAction(_:))
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }

    private func handleAlertAction(_ action: UIAlertAction) {
        navigationDelegate?.didPressAlertAction(self)
    }
}

// MARK: - ProductDetailViewDelegate

extension ProductDetailViewController: ProductDetailViewDelegate {
    func reserveButtonPressed() {
        productDetailView.setButtonToLoadingState()
        apiService.reserveProduct(with: product.id) { [weak self] result in
            switch result {
            case let .success(response):
                self?.showAlert(for: ReservationResponseType(responseString: response.result))
            case .failure:
                self?.showAlert(for: ReservationResponseType.failure)
            }
        }
    }
}
