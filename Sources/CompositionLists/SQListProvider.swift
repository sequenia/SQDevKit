//
//  SQListProvider.swift
//  
//
//  Created by Semen Kologrivov on 23.12.2022.
//

import UIKit
import SQEntities

public protocol SQListProvider: AnyObject {

    /// Collection view
    var collectionView: UICollectionView? { get set }

    /// Parent view or view controller for collection view. Use as delegate for collection's views and cells
    var parent: AnyObject? { get set }

    init()

    @discardableResult
    func setup(collectionView: UICollectionView) -> Self

    @discardableResult
    func setup(collectionView: UICollectionView, parent: AnyObject?) -> Self

    /// Add section with settings
    ///
    /// - Parameters:
    ///   - section: sections content.`SQSectionContent`
    func addSection(
        _ section: SQSectionContent
    ) -> [SQSectionContent]

    /// Add section with settings
    ///
    /// - Parameters:
    ///   - section: sections content.`SQSectionContent`.
    ///   - spacings: section top & bottom spacings.`Spacings`.
    func addSection(
        _ section: SQSectionContent,
        withSpacings spacings: Spacings
    ) -> [SQSectionContent]

    /// Add section with settings
    ///
    /// - Parameters:
    ///   - section: sections content.`SQSectionContent`.
    ///   - spacings: section top & bottom spacings.`Spacings`.
    ///   - backgroundColor: background color of section.`UIColor?`.
    func addSection(
        _ section: SQSectionContent,
        withSpacings spacings: Spacings,
        backgroundColor: UIColor?
    ) -> [SQSectionContent]
}

public extension SQListProvider {

    @discardableResult
    func setup(collectionView: UICollectionView) -> Self {
        self.setup(collectionView: collectionView, parent: nil)
    }

    @discardableResult
    func setup(collectionView: UICollectionView, parent: AnyObject?) -> Self {
        self.collectionView = collectionView
        self.parent = parent

        return self
    }

    func addSection(
        _ section: SQSectionContent
    ) -> [SQSectionContent] {
        self.addSection(section, withSpacings: .default, backgroundColor: nil)
    }

    func addSection(
        _ section: SQSectionContent,
        withSpacings spacings: Spacings
    ) -> [SQSectionContent] {
        self.addSection(section, withSpacings: spacings, backgroundColor: nil)
    }

    func addSection(
        _ section: SQSectionContent,
        withSpacings spacings: Spacings,
        backgroundColor: UIColor?
    ) -> [SQSectionContent] {
        var result = [section]
        let backgroundColor = backgroundColor

        if spacings.top > .zero {
            result.insert(
                SpacerSection(
                    id: "\(section.id)" + .topSpacerAdditional,
                    height: spacings.top,
                    backgroundColor: backgroundColor ?? .clear
                ),
                at: .zero
            )
        }
        if spacings.bottom > .zero {
            result.append(
                SpacerSection(
                    id: "\(section.id)" + .bottomSpacerAdditional,
                    height: spacings.bottom,
                    backgroundColor: backgroundColor ?? .clear
                )
            )
        }
        return result
    }
}

// MARK: - String
private extension String {

    static let topSpacerAdditional = "topSpacer"
    static let bottomSpacerAdditional = "bottomSpacer"
}
