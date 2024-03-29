//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 14.09.2021.
//

import UIKit

public extension UIBezierPath {

    /// Creates UIBezier path for rect with different corner radius
    /// - Parameters:
    ///   - shouldRoundRect: rectangle. `CGRect`
    ///   - topLeft: radius of top left corner. `CGFloat`
    ///   - topRight: radius of top right corner. `CGFloat`
    ///   - bottomLeft: radius of bottom left corner. `CGFloat`
    ///   - bottomRight: radius of bottom right corner. `CGFloat`
    convenience init(
        shouldRoundRect rect: CGRect,
        topLeftRadius: CGFloat = .zero,
        topRightRadius: CGFloat = .zero,
        bottomLeftRadius: CGFloat = .zero,
        bottomRightRadius: CGFloat = .zero
    ) {
        self.init(
            shouldRoundRect: rect,
            topLeftRadius: .init(width: topLeftRadius, height: topLeftRadius),
            topRightRadius: .init(width: topRightRadius, height: topRightRadius),
            bottomLeftRadius: .init(width: bottomLeftRadius, height: bottomLeftRadius),
            bottomRightRadius: .init(width: bottomRightRadius, height: bottomRightRadius)
        )
    }

    /// Creates UIBezier path for rect with different corner radius
    /// - Parameters:
    ///   - shouldRoundRect: rectangle. `CGRect`
    ///   - topLeft: radius of top left corner. `CGSize`
    ///   - topRight: radius of top right corner. `CGSize`
    ///   - bottomLeft: radius of bottom left corner. `CGSize`
    ///   - bottomRight: radius of bottom right corner. `CGSize`
    convenience init(
        shouldRoundRect rect: CGRect,
        topLeftRadius: CGSize = .zero,
        topRightRadius: CGSize = .zero,
        bottomLeftRadius: CGSize = .zero,
        bottomRightRadius: CGSize = .zero
    ) {
        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero {
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero {
            path.addLine(
                to: CGPoint(x: topRight.x - topRightRadius.width, y: topRight.y)
            )
            path.addCurve(
                to: CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height),
                control1: CGPoint(x: topRight.x, y: topRight.y),
                control2: CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height)
            )
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero {
            path.addLine(
                to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height)
            )
            path.addCurve(
                to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y),
                control1: CGPoint(x: bottomRight.x, y: bottomRight.y),
                control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y)
            )
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero {
            path.addLine(
                to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y)
            )
            path.addCurve(
                to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height),
                control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y),
                control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height)
            )
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(
                to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y),
                control1: CGPoint(x: topLeft.x, y: topLeft.y),
                control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y)
            )
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        self.cgPath = path
    }
}
