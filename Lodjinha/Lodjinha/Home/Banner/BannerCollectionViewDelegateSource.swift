//
//  BannerCollectionViewDelegateSource.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 06/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

final class BannerCollectionViewDelegateSource: NSObject {

    private var banners: [Banner] = []

    func setBanners(_ banners: [Banner]) {
        self.banners = banners
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BannerCollectionViewDelegateSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDataSource

extension BannerCollectionViewDelegateSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as BannerCollectionViewCell
        cell.setImage(banners[indexPath.item].image)
        return cell
    }
}
