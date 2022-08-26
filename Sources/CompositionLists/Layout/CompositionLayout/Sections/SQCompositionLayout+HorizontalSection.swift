//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 24.08.2022.
//

import UIKit

@available(iOS 13.0, *)
public extension NSCollectionLayoutSection {
    /// Make a horizontal layout
    ///
    ///  - Parameters:
    ///   - scrollBehavior: The section’s scrolling behavior in relation to the main layout axis.`UICollectionLayoutSectionOrthogonalScrollingBehavior`.
    ///
    /// Example Layout:
    ///        ──────────────────
    ///        ──                                                  ──
    ///        ──                                                  ──
    ///        ──                                                  ──
    ///        ──────────────────
    static func createHorizontalLayoutSection(
        itemWidth: NSCollectionLayoutDimension,
        itemHeight: NSCollectionLayoutDimension,
        itemsSpacing: CGFloat = .zero,
        groupContentInsets: NSDirectionalEdgeInsets = .zero,
        sectionContentInsets: NSDirectionalEdgeInsets = .zero,
        scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1),
           heightDimension: itemHeight
       )

       let groupSize = NSCollectionLayoutSize(
           widthDimension: itemWidth,
           heightDimension: itemHeight
       )

       let item = NSCollectionLayoutItem(layoutSize: itemSize)

       let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitems: [item]
       )
        group.contentInsets = groupContentInsets

       let layoutSection = NSCollectionLayoutSection(group: group)
       layoutSection.interGroupSpacing = itemsSpacing

       layoutSection.orthogonalScrollingBehavior = scrollBehavior
       layoutSection.contentInsets = sectionContentInsets
       return layoutSection
    }
}
