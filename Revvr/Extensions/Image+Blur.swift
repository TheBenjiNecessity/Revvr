//
//  Image+Blur.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-17.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

extension UIImage {
    /// Applies a gaussian blur to the image.
    ///
    /// - Parameter radius: Blur radius.
    /// - Returns: A blurred image.
    func blur(radius: CGFloat = 6.0) -> UIImage? {
        let context = CIContext()
        guard let inputImage = CIImage(image: self),
              let clampFilter = CIFilter(name: "CIAffineClamp"),
              let blurFilter = CIFilter(name: "CIGaussianBlur")
        else { return nil }

        clampFilter.setDefaults()
        clampFilter.setValue(inputImage, forKey: kCIInputImageKey)

        blurFilter.setDefaults()
        blurFilter.setValue(clampFilter.outputImage, forKey: kCIInputImageKey)
        blurFilter.setValue(radius, forKey: kCIInputRadiusKey)

        guard let blurredImage = blurFilter.value(forKey: kCIOutputImageKey) as? CIImage,
              let cgImage = context.createCGImage(blurredImage, from: inputImage.extent)
        else { return nil }

        return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
    }
}
