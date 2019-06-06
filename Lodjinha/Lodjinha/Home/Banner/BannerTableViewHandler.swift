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
    private var banners: [Banner] = []

    init(apiService: BannerApiProtocol = BannerAPI()) {
        self.apiService = apiService
        fetchBanners()
    }

    private func fetchBanners() {
        apiService.getBanners { [weak self] result in
            switch result {
            case let .success(response):
                self?.getBannerImage(response: response.data)
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
            self.banners = banners
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
        cell.banners = banners
        return cell
    }
}
