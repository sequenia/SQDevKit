//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 14.09.2021.
//

import UIKit

public enum GradientDirection {

    case topBottom
    case topLeftBottomRight
    case topRightBottomLeft
    case leftRight
    case custom(fromY: CGFloat, toY: CGFloat)

    var pointsLayer: [CGPoint] {
        switch self {
        case .topBottom:
            return [CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1)]

        case .topLeftBottomRight:
            return [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1)]

        case .topRightBottomLeft:
            return [CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1)]

        case .leftRight:
            return [CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5)]

        case .custom(let fromY, let toY):
            return [CGPoint(x: 0.5, y: fromY), CGPoint(x: 0.5, y: toY)]

        }
    }

    func pointsView(size: CGSize) -> [CGPoint] {
        let width = size.width
        let height = size.height
        switch self {
        case .topBottom:
            return [CGPoint(x: width / 2, y: 0), CGPoint(x: width / 2, y: height)]

        case .topLeftBottomRight:
            return [.zero, CGPoint(x: width, y: height)]

        case .topRightBottomLeft:
            return [CGPoint(x: width, y: 0), CGPoint(x: 0, y: height)]

        case .leftRight:
            return [CGPoint(x: 0, y: height / 2), CGPoint(x: width, y: height / 2)]

        case .custom(let fromY, let toY):
            return [CGPoint(x: width / 2, y: fromY), CGPoint(x: width / 2, y: toY)]

        }
    }
}

public extension SQExtensions where Base: UIView {

    func layer(withName name: String) -> CALayer? {
        (self.base.layer.sublayers ?? []).first(where: { ($0 as? CAGradientLayer)?.name == name }) as? CAGradientLayer
    }

    func addGradientLayer(
        withName name: String,
        colors: [UIColor?],
        direction: GradientDirection = .topBottom,
        locations: [CGFloat] = [0, 1],
        bounds: CGRect? = nil
    ) {
        self.removeLayer(withName: name)

        let gradientLayer = CAGradientLayer()
        gradientLayer.name = name
        gradientLayer.colors = colors.map { $0?.cgColor as Any }
        gradientLayer.startPoint = direction.pointsLayer.first ?? .zero
        gradientLayer.endPoint = direction.pointsLayer.last ?? .zero

        gradientLayer.locations = locations.map { $0 as NSNumber }
        if let frame = bounds {
            gradientLayer.frame = frame
        } else {
            gradientLayer.frame = self.base.bounds
        }

        gradientLayer.zPosition = -9999
        self.base.layer.addSublayer(gradientLayer)
    }

    func removeLayer(withName name: String) {
        self.layer(withName: name)?.removeFromSuperlayer()
    }
}
