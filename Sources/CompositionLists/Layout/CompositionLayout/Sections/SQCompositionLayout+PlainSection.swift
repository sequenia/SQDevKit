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
    static func createPlainLayoutSection(
        estimatedHeight: NSCollectionLayoutDimension = .defaultEstimatedHeight
    ) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: estimatedHeight
        )
        let item = NSCollectionLayoutItem(
            layoutSize: size
        )

        return NSCollectionLayoutSection(
            group: .vertical(
                layoutSize: size,
                subitems: [item]
            )
        )
    }
}
