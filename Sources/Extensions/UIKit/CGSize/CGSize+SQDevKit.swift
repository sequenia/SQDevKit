//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQExtensions where Base == CGSize {

    /// Scales size by the next algorithm:
    /// - original size width replaces with `width` from parameter
    /// - original size height changes proportionaly
    ///
    /// - Parameters:
    ///   - width: target width for scale.`CGFloat`.
    /// - Returns: scaled `CGSize`
    func scaleProportional(toWidth width: CGFloat) -> CGSize {
        let widthRatio = width / self.base.width

        let newSize = CGSize(width: self.base.width * widthRatio,
                             height: self.base.height * widthRatio)
        return newSize
    }

    /// Scales size to fit that into `targetSize`
    ///
    /// - Parameters:
    ///   - targetSize: size to fit. `CGSize`.
    /// - Returns: scaled size
    func scaleProportional(toSize targetSize: CGSize) -> CGSize {
        let widthRatio = targetSize.width / self.base.width
        let heightRatio = targetSize.height / self.base.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: self.base.width * heightRatio,
                             height: self.base.height * heightRatio)
        } else {
            newSize = CGSize(width: self.base.width * widthRatio,
                             height: self.base.height * widthRatio)
        }
        return newSize
    }
}

extension CGSize: SQExtensionsCompatible {}
