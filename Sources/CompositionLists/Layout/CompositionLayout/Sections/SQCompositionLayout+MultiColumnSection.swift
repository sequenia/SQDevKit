//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 24.08.2022.
//

import UIKit

@available(iOS 13.0, *)
public extension NSCollectionLayoutSection {

// MARK: - createMultiColumnLayoutSection
    /// Make a two column layout
    ///
    ///  - Parameters:
    ///   - uiSettings: Settings for layout, can choose default - twoColumnSettings.`SQSectionSettings`.
    ///
    /// Example Layout:
    ///    ──────────────────
    ///    ──                     ──                       ──
    ///    ──                     ──                       ──
    ///    ──      item1      ──       item2       ──
    ///    ──                     ──                       ──
    ///    ──                     ──                       ──
    ///    ──                     ──                       ──
    ///    ──────────────────
    ///    ──────────────────
    ///    ──                     ──                       ──
    ///    ──                     ──                       ──
    ///    ──      item3      ──       item4       ──
    ///    ──                     ──                       ──
    ///    ──                     ──                       ──
    ///    ──                     ──                       ──
    ///    ──────────────────
    static func createMultiColumnLayoutSection(
        columnsCount: Int,
        itemHeight: NSCollectionLayoutDimension,
        itemsHorizontalSpacing: NSCollectionLayoutSpacing = .zero,
        itemsVerticalSpacing: CGFloat = .zero,
        groupContentInsets: NSDirectionalEdgeInsets = .zero,
        sectionContentInsets: NSDirectionalEdgeInsets = .zero
    ) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1 / CGFloat(columnsCount)),
                heightDimension: itemHeight
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: itemHeight
            ),
            subitem: item,
            count: columnsCount
        )

        group.interItemSpacing = itemsHorizontalSpacing
        group.contentInsets = groupContentInsets

        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.interGroupSpacing = itemsVerticalSpacing
        sectionLayout.contentInsets = sectionContentInsets
        
        return sectionLayout
    }
}
