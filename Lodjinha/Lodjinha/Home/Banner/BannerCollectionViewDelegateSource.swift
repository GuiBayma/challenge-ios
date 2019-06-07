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
        var bannersCorrectedImages: [Banner] = []
        banners.forEach { banner in
            let bannerOldImage: UIImage? = banner.image
            let targetSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
            let newImage: UIImage? = resizeImage(image: bannerOldImage, targetSize: targetSize)
            let newBanner: Banner = Banner(image: newImage)
            bannersCorrectedImages.append(newBanner)
        }
        self.banners = bannersCorrectedImages
    }

    private func resizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
        guard let image = image else { return nil }

        let size: CGSize = image.size
        let widthRatio: CGFloat = targetSize.width  / size.width
        let heightRatio: CGFloat = targetSize.height / size.height

        let newRatio: CGFloat = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize: CGSize = CGSize(width: size.width * newRatio, height: size.height * newRatio)

        let rect: CGRect = CGRect(origin: .zero, size: newSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
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
