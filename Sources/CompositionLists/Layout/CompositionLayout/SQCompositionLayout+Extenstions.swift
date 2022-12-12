//
//  SQCompositionLayout+Extenstions.swift
//  SQExtensions
//
//  Created by Nikolay Komissarov on 15.08.2022.
//

import UIKit

@available(iOS 13.0, *)
public extension NSCollectionLayoutSpacing {

    static let zero = NSCollectionLayoutSpacing.fixed(.zero)
}

@available(iOS 13.0, *)
public extension NSCollectionLayoutEdgeSpacing {

    static let zero = NSCollectionLayoutEdgeSpacing(
        leading: .zero,
        top: .zero,
        trailing: .zero,
        bottom: .zero
    )
}

@available(iOS 13.0, *)
public extension NSCollectionLayoutDimension {

    static let defaultEstimatedWidth  = NSCollectionLayoutDimension.estimated(44)
    static let defaultEstimatedHeight = NSCollectionLayoutDimension.estimated(44)
}
