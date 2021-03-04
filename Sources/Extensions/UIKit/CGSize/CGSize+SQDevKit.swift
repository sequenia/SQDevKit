//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension CGSize {

    /// Scales size by the next algorithm:
    /// - original size width replaces with `width` from parameter
    /// - original size height changes proportionaly
    ///
    /// - Parameters:
    ///   - width: target width for scale.`CGFloat`.
    /// - Returns: scaled `CGSize`
    func scaleProportional(toWidth width: CGFloat) -> CGSize {
        let widthRatio = width / self.width

        let newSize = CGSize(width: self.width * widthRatio,
                             height: self.height * widthRatio)
        return newSize
    }

    /// Scales size to fit that into `targetSize`
    ///
    /// - Parameters:
    ///   - targetSize: size to fit. `CGSize`.
    /// - Returns: scaled size
    func scaleProportional(toSize targetSize: CGSize) -> CGSize {
        let widthRatio = targetSize.width / self.width
        let heightRatio = targetSize.height / self.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: self.width * heightRatio,
                             height: self.height * heightRatio)
        } else {
            newSize = CGSize(width: self.width * widthRatio,
                             height: self.height * widthRatio)
        }
        return newSize
    }
}
