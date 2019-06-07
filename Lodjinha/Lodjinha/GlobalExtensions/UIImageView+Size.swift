//
//  UIImageView+Size.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 07/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(_ image: UIImage?, targetSize: CGSize) {
        guard let image = image else { return }

        let size: CGSize = image.size
        let widthRatio: CGFloat = targetSize.width / size.width
        let heightRatio: CGFloat = targetSize.height / size.height

        let newRatio: CGFloat = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize: CGSize = CGSize(width: size.width * newRatio, height: size.height * newRatio)

        let rect: CGRect = CGRect(origin: .zero, size: newSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.image = newImage
    }
}
