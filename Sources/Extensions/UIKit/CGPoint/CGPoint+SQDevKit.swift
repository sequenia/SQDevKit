//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 20.09.2021.
//

import UIKit

public extension SQExtensions where Base == CGPoint {

    /// Scales size by the next algorithm:
    /// - original size width replaces with `width` from parameter
    /// - original size height changes proportionally
    ///
    /// - Parameters:
    ///   - width: target width for scale.`CGFloat`.
    /// - Returns: scaled `CGSize`
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(self.base.x - point.x, 2) + pow(self.base.y - point.y, 2))
    }
}

public extension CGPoint {
    
    /// Add two CGPoints by coordinates
    ///
    /// - Parameters:
    ///  - lhs: CGPoint
    ///  - rhs: CGPoint
    /// - Returns: sum of two CGPoints
    static func + (
        lhs: CGPoint,
        rhs: CGPoint
    ) -> CGPoint {
        .init(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }
}

extension CGPoint: SQExtensionsCompatible {}
