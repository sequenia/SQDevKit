//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 24.08.2022.
//

import UIKit

@available(iOS 13.0, *)
public extension NSCollectionLayoutSection {

// MARK: - createPlainLayoutSection
    static func createPlainLayoutSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .defaultEstimatedHeight
        )
        let item = NSCollectionLayoutItem(
            layoutSize: size
        )

        return NSCollectionLayoutSection(
            group: .horizontal(
                layoutSize: size,
                subitem: item,
                count: 1
            )
        )
    }
}
