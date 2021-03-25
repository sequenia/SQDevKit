//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIImage {

    /// Image's width
    var width: CGFloat {
        self.base.size.width
    }

    /// Image's height
    var height: CGFloat {
        self.base.size.width
    }

    /// Create image with full color fill
    ///
    /// - Parameters:
    ///   - color: color for fill image. `UIColor`
    ///   - rect: result image frame. `CGRect`
    ///
    /// - Returns: filled with color image
    static func create(withColor color: UIColor?,
                       rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color?.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }

    /// Scales image to fit that into `targetSize`
    ///
    /// - Parameters:
    ///   - targetSize: size to fit. `CGSize`.
    /// - Returns: scaled image
    func resize(toTargetSize targetSize: CGSize) -> UIImage {
        let image = self.base

        let newSize = image.size.sq.scaleProportional(toSize: targetSize)

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? UIImage()
    }

    /// Fix orientation for image
    ///
    /// - Returns: fixed image
    func fixOrientation() -> UIImage? {
        let image = self.base

        guard image.imageOrientation != UIImage.Orientation.up else {
            return image.copy() as? UIImage
        }

        guard let cgImage = image.cgImage else { return nil }

        guard let colorSpace = cgImage.colorSpace,
            let ctx = CGContext(data: nil,
                                width: Int(image.size.width),
                                height: Int(image.size.height),
                                bitsPerComponent: cgImage.bitsPerComponent,
                                bytesPerRow: 0,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil
        }

        var transform = CGAffineTransform.identity

        switch image.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: CGFloat.pi)

        case .left, .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)

        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)

        case .up, .upMirrored:
            break
        @unknown default:
            break
        }

        switch image.imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: image.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)

        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: image.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)

        case .up, .down, .left, .right:
            break
        @unknown default:
            break
        }

        ctx.concatenate(transform)

        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0,
                                         y: 0,
                                         width: image.size.height,
                                         height: image.size.width))

        default:
            ctx.draw(cgImage, in: CGRect(x: 0,
                                         y: 0,
                                         width: image.size.width,
                                         height: image.size.height))
        }

        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage(cgImage: newCGImage, scale: 1, orientation: .up)
    }

}
