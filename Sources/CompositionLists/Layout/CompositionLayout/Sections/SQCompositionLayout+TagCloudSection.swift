//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 24.08.2022.
//

import UIKit

@available(iOS 13.0, *)
public extension NSCollectionLayoutSection {

// MARK: - createTagsCloudLayoutSection
    /// Make a tags cloud layout
    ///
    ///  - Parameters:
    ///   - uiSettings: Settings for layout, can choose default - tagsCloudSettings.`SQSectionSettings`.
    ///
    /// Example Layout:
    ///    |───|  |────────| |──────|
    ///    |──────||───| |──────|
    ///    |─────|
    static func createTagsCloudLayoutSection(
        itemEdgeSpacing: NSCollectionLayoutEdgeSpacing = .zero,
        itemsHorizontalSpacing: NSCollectionLayoutSpacing = .fixed(.zero),
        groupContentInsets: NSDirectionalEdgeInsets = .zero,
        sectionContentInsets: NSDirectionalEdgeInsets = .zero
    ) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .defaultEstimatedWidth,
                heightDimension: .defaultEstimatedHeight
            )
        )
        item.edgeSpacing = itemEdgeSpacing

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .defaultEstimatedHeight
            ),
            subitems: [item]
        )
        group.contentInsets = groupContentInsets
        group.interItemSpacing = itemsHorizontalSpacing

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionContentInsets
        return section
    }
}
