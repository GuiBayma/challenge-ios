//
//  ProductsListViewController.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

protocol ProductsListControllerNavigationDelegate: AnyObject {
    func productsListController(_ controller: ProductsListViewController, didSelect product: Product)
}

final class ProductsListViewController: UIViewController {

    weak var navigationDelegate: ProductsListControllerNavigationDelegate?
    private let category: Category
    private let delegateSource: ProductsListDelegateSourceProtocol
    private let apiService: ProductsListApiProtocol
    private lazy var productsListView: ProductsListView = ProductsListView(delegateSource: delegateSource)
    private var offset: Int = 0
    private var limit: Int = 20
    private var total: Int = 0
    private var isLoading: Bool = false

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(category: Category,
         apiService: ProductsListApiProtocol = ProductsListAPI(),
         delegateSource: ProductsListDelegateSourceProtocol = ProductsListTableViewDelegateSource()) {
        self.category = category
        self.apiService = apiService
        self.delegateSource = delegateSource
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Controller lifecycle

    override func loadView() {
        self.view = productsListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        delegateSource.delegate = self
        delegateSource.cellDelegate = self
        getProductsList()
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
        navigationController?.configureNavigationBar(with: category.description)
    }

    // MARK: - Fetch products

    private func getProductsList() {
        guard !isLoading else { return }
        isLoading = true
        apiService.getProductsList(for: category.id, offset: offset, limit: limit) { [weak self] result in
            switch result {
            case let .success(response):
                self?.offset = response.offset + response.data.count
                self?.total = response.total
                let products: [Product] = response.data.map {
                    Product(name: $0.nome,
                            imageUrlString: $0.urlImagem,
                            description: $0.descricao,
                            image: nil,
                            oldPrice: $0.precoDe,
                            currentPrice: $0.precoPor,
                            categoryName: $0.categoria.descricao)
                }
                self?.delegateSource.updateProducts(products)
                self?.productsListView.reloadTableView()
            case .failure:
                break
            }
            self?.isLoading = false
        }
    }
}

// MARK: - BestSellerTableViewCellDelegate

extension ProductsListViewController: BestSellerTableViewCellDelegate {
    func bestSellerTableViewCell(_ cell: BestSellerTableViewCell, getImage urlString: String) {
        apiService.getProductImage(imageUrl: urlString) { [weak self] result in
            var image: UIImage = Asset.placeholderImage.image
            switch result {
            case let .success(response):
                image = response
            case .failure:
                break
            }
            self?.delegateSource.updateProduct(with: image, at: cell.index)
            self?.productsListView.reloadTableViewRows(at: [IndexPath(row: cell.index, section: 0)])
        }
    }

    func didTapCell(_ cell: BestSellerTableViewCell) {}
}

// MARK: - ProductsListDelegateSourceDelegate

extension ProductsListViewController: ProductsListDelegateSourceDelegate {
    func shouldLoadMoreProducts() {
        guard !isLoading else { return }
        let newLimit: Int = total - offset
        if newLimit <= 0 {
            return
        }
        if newLimit < limit {
            limit = newLimit
        }
        getProductsList()
    }

    func didSelectProduct(product: Product) {
        navigationDelegate?.productsListController(self, didSelect: product)
    }
}
