//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 24.08.2022.
//

import UIKit

@available(iOS 13.0, *)
public extension NSCollectionLayoutSection {

// MARK: - createTilesLayoutSection
    /// Make a tiles layout
    ///
    ///  - Parameters:
    ///   - uiSettings: Settings for layout, can choose default - tilesSettings.`SQSectionSettings`.
    ///   - metrics: metrics for tile width
    ///
    /// Example Layout:
    /// |–––––––––––––––––––––––––––|
    /// |                    tile 1                          |
    /// |–––––––––––––––––––––––––––|
    /// |    tile 2  |                  tile 3              |
    /// |    tile 2  |                  tile 3              |
    /// |–––––––––––––––––––––––––––|
    /// |         tile 4                     |    tile 5    |
    /// |         tile 4                     |    tile 5    |
    /// |–––––––––––––––––––––––––––|

    static func createTilesLayoutSection(
        itemHeight: NSCollectionLayoutDimension,
        itemsHorizontalSpacing: CGFloat = .zero,
        itemsVerticalSpacing: CGFloat = .zero,
        groupContentInsets: NSDirectionalEdgeInsets = .zero,
        sectionContentInsets: NSDirectionalEdgeInsets = .zero,
        widths: [CGFloat]
    ) -> NSCollectionLayoutSection {
        var itemsGrouping = [[CGFloat]]()
        var currentGroup = [CGFloat]()
        var currentSum: CGFloat = .zero

        widths.enumerated()
            .forEach { index, width in
                if currentSum + width <= 1 {
                    currentGroup.append(width)
                    currentSum += width
                } else {
                    itemsGrouping.append(currentGroup)
                    currentSum = width
                    currentGroup = [width]
                }
                if index == widths.count - 1 {
                    itemsGrouping.append(currentGroup)
                }
            }

        let groups = itemsGrouping.map { widths -> NSCollectionLayoutGroup in
            let spacingsCount = CGFloat(widths.count - 1)
            let availableWidth: CGFloat = UIScreen.main.bounds.width -
                sectionContentInsets.leading -
                sectionContentInsets.trailing -
                itemsHorizontalSpacing * spacingsCount
            let items = widths.map { width -> NSCollectionLayoutItem in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(availableWidth * width),
                    heightDimension: .fractionalHeight(1)
                )
                return NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
            }
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: itemHeight
                ),
                subitems: items
            )
            group.interItemSpacing = .fixed(itemsHorizontalSpacing)
            return group
        }

        let mainGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .defaultEstimatedHeight
            ),
            subitems: groups
        )

        mainGroup.interItemSpacing = .fixed(itemsVerticalSpacing)
        mainGroup.contentInsets = groupContentInsets

        let section = NSCollectionLayoutSection(group: mainGroup)
        section.contentInsets = sectionContentInsets
        
        return section
    }
}
