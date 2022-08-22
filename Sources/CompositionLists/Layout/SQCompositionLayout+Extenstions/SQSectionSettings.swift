//
//  SQSectionSettings.swift
//  SQExtensions
//
//  Created by Nikolay Komissarov on 15.08.2022.
//

import UIKit

@available(iOS 13.0, *)

// MARK: - SQSectionSettings
public struct SQSectionSettings {
    
    let groupSize: NSCollectionLayoutSize
    let alternativeGroupSize: NSCollectionLayoutSize
    let itemSize: NSCollectionLayoutSize
    let itemEdgeSpacing: NSCollectionLayoutEdgeSpacing
    let groupEdgeSpacing: NSCollectionLayoutEdgeSpacing
    let groupInterItemSpacing: NSCollectionLayoutSpacing
    let groupContentInsets: NSDirectionalEdgeInsets
    let sectionLayoutContentInsets: NSDirectionalEdgeInsets
    let bannersVerticalWidth: CGFloat
    let bannersVerticalItemsSpacing: CGFloat
    
// MARK: - Init
    public init(
        groupSize: NSCollectionLayoutSize,
        alternativeGroupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ),
        itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ),
        itemEdgeSpacing: NSCollectionLayoutEdgeSpacing = .init(
            leading: .none,
            top: .none,
            trailing: .none,
            bottom: .none
        ),
        groupInterItemSpacing: NSCollectionLayoutSpacing = .fixed(.zero),
        groupContentInsets: NSDirectionalEdgeInsets = .zero,
        sectionLayoutContentInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(),
        groupEdgeSpacing: NSCollectionLayoutEdgeSpacing = .init(
            leading: .none,
            top: .none,
            trailing: .none,
            bottom: .none
        ),
        bannersVerticalWidth: CGFloat = UIScreen.sq.width - 16 * 2,
        bannersVerticalItemsSpacing: CGFloat = 6
    ) {
        
        self.groupSize = groupSize
        self.itemSize = itemSize
        self.itemEdgeSpacing = itemEdgeSpacing
        self.groupInterItemSpacing = groupInterItemSpacing
        self.groupContentInsets = groupContentInsets
        self.groupEdgeSpacing = groupEdgeSpacing
        self.sectionLayoutContentInsets = sectionLayoutContentInsets
        self.alternativeGroupSize = alternativeGroupSize
        self.bannersVerticalWidth = bannersVerticalWidth
        self.bannersVerticalItemsSpacing = bannersVerticalItemsSpacing
    }
}

// MARK: - Default
@available(iOS 13.0, *)
public extension SQSectionSettings {
    
// MARK: - defaultFiltersSettings
    static var defaultFiltersSettings: SQSectionSettings {
        return .init(
            groupSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(.defaultEstimated)
            ),
            itemSize: .init(
                widthDimension: .estimated(.defaultEstimated),
                heightDimension: .estimated(.defaultEstimated)
            ),
            itemEdgeSpacing: .init(
                leading: nil,
                top: .fixed(12),
                trailing: nil,
                bottom: nil
            ),
            groupInterItemSpacing: .fixed(8),
            groupContentInsets: .init(
                top: .zero,
                leading: .defaultHoriontalSpacing,
                bottom: .zero,
                trailing: .defaultHoriontalSpacing
            )
        )
    }
    
// MARK: - defaultTwoColumnSettings
    static var defaultTwoColumnSettings: SQSectionSettings {
        return .init(
            groupSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(.heightCell)
            ),
            itemSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(.heightCell)
            ),
            groupInterItemSpacing: .fixed(.groupHorizontalSpace * 2),
            groupContentInsets: .init(
                top: .zero,
                leading: .groupHorizontalSpace,
                bottom: .zero,
                trailing: .groupHorizontalSpace
            ),
            sectionLayoutContentInsets: .init(
                top: .zero,
                leading: .zero,
                bottom: .defaultVerticalSpacing,
                trailing: .zero
            ),
            groupEdgeSpacing: .init(
                leading: nil,
                top: nil,
                trailing: nil,
                bottom: .fixed(.defaultHoriontalSpacing / 2)
            )
        )
    }
    
// MARK: - defaultHorizontalBannerSettings
    static var defaultHorizontalBannerSettings: SQSectionSettings {
        .init(
            groupSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(.bannerImageHeight)
            ),
            itemSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ),
            sectionLayoutContentInsets: .init(
                top: .defaultVerticalSpacing,
                leading: .zero,
                bottom: .defaultVerticalSpacing,
                trailing: .zero
            )
        )
    }
    
// MARK: - defaultVerticalBannersSettings
    static var defaultVerticalBannersSettings: SQSectionSettings {
        .init(
            groupSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(.bannerImageHeight)
            ),
            alternativeGroupSize: .init(
                widthDimension: .absolute(.defaultBlockWidth),
                heightDimension: .estimated(.defaultEstimated)
            ),
            groupInterItemSpacing: .fixed(.verticalBannersItemsSpacing),
            sectionLayoutContentInsets: .init(
                top: .defaultVerticalSpacing,
                leading: .defaultHoriontalSpacing,
                bottom: .defaultVerticalSpacing,
                trailing: .defaultHoriontalSpacing
            )
        )
    }
}

// MARK: - Constants
private extension CGFloat {
    
    static let defaultEstimated: CGFloat = 44
    static let defaultHoriontalSpacing: CGFloat = 16
    static let defaultVerticalSpacing: CGFloat = 16
    static let groupHorizontalSpace: CGFloat = 18
    static let heightCell: CGFloat = Swift.min(300, UIScreen.sq.height * 0.40)
    static let bannerImageHeight: CGFloat = UIScreen.sq.width * 180 / 375
    static let verticalBannersItemsSpacing: CGFloat = 6
    static let defaultBlockWidth: CGFloat = UIScreen.sq.width - .defaultHoriontalSpacing * 2
}

