//
//  SQCompositionLayout+Extenstions.swift
//  SQExtensions
//
//  Created by Nikolay Komissarov on 15.08.2022.
//

import UIKit

@available(iOS 13.0, *)
public extension NSCollectionLayoutSection {
    
// MARK: - createFiltersLayoutSection
    static func createFiltersLayoutSection(
        uiSettings: SQSectionSettings
    ) -> NSCollectionLayoutSection {
        let groupSize = uiSettings.groupSize
        let itemSize = uiSettings.itemSize
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = uiSettings.itemEdgeSpacing
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        group.interItemSpacing = uiSettings.groupInterItemSpacing
        group.contentInsets = uiSettings.groupContentInsets
        
        return NSCollectionLayoutSection(group: group)
    }
    
// MARK: - createTwoColumnLayoutSection
    static func createTwoColumnLayoutSection(
        uiSettings: SQSectionSettings
    ) -> NSCollectionLayoutSection {
        let itemSize = uiSettings.itemSize
        
        let groupSize = uiSettings.groupSize
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        
        group.interItemSpacing = uiSettings.groupInterItemSpacing
        group.edgeSpacing = uiSettings.groupEdgeSpacing
        group.contentInsets = uiSettings.groupContentInsets

        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.contentInsets = uiSettings.sectionLayoutContentInsets

        return sectionLayout
    }
    
// MARK: - createHorizontalBannersLayoutSection
    static func createHorizontalBannersLayoutSection(
        uiSettings: SQSectionSettings,
        scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> NSCollectionLayoutSection {
        let groupSize = uiSettings.groupSize
        let itemSize = uiSettings.itemSize

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )

        let layoutSection = NSCollectionLayoutSection(group: group)
        
        layoutSection.orthogonalScrollingBehavior = scrollBehavior
        layoutSection.contentInsets = uiSettings.sectionLayoutContentInsets
        
        return layoutSection
    }
    
// MARK: - createVerticalBannersLayoutSection
    static func createVerticalBannersBlockLayoutSection(
        uiSettings: SQSectionSettings,
        metrics: [SQSectionMetrics]
    ) -> NSCollectionLayoutSection {
        var itemsGrouping = [[CGFloat]]()
        var currentGroup = [CGFloat]()
        var currentSum: CGFloat = .zero

        metrics.enumerated()
            .forEach { index, metric in
                if currentSum + metric.width <= 1 {
                    currentGroup.append(metric.width)
                    currentSum += metric.width
                } else {
                    itemsGrouping.append(currentGroup)
                    currentSum = metric.width
                    currentGroup = [metric.width]
                }
                if index == metrics.count - 1 {
                    itemsGrouping.append(currentGroup)
                }
            }

        let groups = itemsGrouping.map { widths -> NSCollectionLayoutGroup in
            let spacingsCount = CGFloat(widths.count - 1)
            let availableWidth: CGFloat = uiSettings.bannersVerticalWidth - uiSettings.bannersVerticalItemsSpacing * spacingsCount
            let items = widths.map { width -> NSCollectionLayoutItem in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(availableWidth * width),
                    heightDimension: .fractionalHeight(1)
                )
                return NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
            }
            let groupSize = uiSettings.groupSize
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: items
            )
            group.interItemSpacing = uiSettings.groupInterItemSpacing
            return group
        }

        let mainGroupSize = uiSettings.alternativeGroupSize

        let mainGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: mainGroupSize,
            subitems: groups
        )
        
        mainGroup.interItemSpacing = uiSettings.groupInterItemSpacing

        let layoutSection = NSCollectionLayoutSection(group: mainGroup)
        layoutSection.contentInsets = uiSettings.sectionLayoutContentInsets
        return layoutSection
    }
    
// MARK: - createPlainLayoutSection
    static func createPlainLayoutSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(44)
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
