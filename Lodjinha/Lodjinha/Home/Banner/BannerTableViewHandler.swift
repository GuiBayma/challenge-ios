//
//  BannerTableViewHandler.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 05/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class BannerTableViewHandler {
    weak var delegate: TableViewHandlerActionDelegate?
    private let apiService: BannerApiProtocol
    private var isCellLoading: Bool = true
    private let bannerCollectionDelegateSource: BannerCollectionViewDelegateSource

    init(apiService: BannerApiProtocol = BannerAPI(),
         bannerCollectionDelegateSource: BannerCollectionViewDelegateSource = BannerCollectionViewDelegateSource()) {
        self.apiService = apiService
        self.bannerCollectionDelegateSource = bannerCollectionDelegateSource
        fetchBanners()
    }

    private func fetchBanners() {
        apiService.getBanners { [weak self] result in
            switch result {
            case let .success(response):
                let banners: [BannerResponse] = response.data
                self?.getBannerImage(response: banners)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func getBannerImage(response: [BannerResponse]) {
        var banners: [Banner] = []
        let dispatchGroup: DispatchGroup = DispatchGroup()

        response.forEach { banner in
            dispatchGroup.enter()
            apiService.getBannerImage(imageUrl: banner.urlImagem) { result in
                switch result {
                case let .success(response):
                    banners.append(Banner(image: response))
                case let .failure(error):
                    print(error.localizedDescription)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.isCellLoading = false
            self.bannerCollectionDelegateSource.setBanners(banners)
            self.delegate?.updateTableView(section: 0)
        }
    }
}

// MARK: - TableViewHandlerDelegate

extension BannerTableViewHandler: TableViewHandlerDelegate {
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as BannerTableViewCell
        cell.setCollectionViewDelegateDataSource(bannerCollectionDelegateSource)
        if !isCellLoading {
            cell.updateCollectionView()
        }
        return cell
    }
}
