//
//  File.swift
//
//
//  Created by Semen Kologrivov on 11.01.2022.
//

import UIKit

#if canImport(SQExtensions)
import SQExtensions
#endif

/// Protocol for factories - classes depends on registration and displaying specific views and cells by models
public protocol SQListFactory: AnyObject {

    /// Collection view
    var collectionView: UICollectionView? { get set }

    /// Parent view or view controller for collection view. Use as delegate for collection's views and cells
    var parent: AnyObject? { get set }

    init(collectionView: UICollectionView)
    init(collectionView: UICollectionView, parent: AnyObject?)

    /// Register all cells and views
    func registerElements()

    /// Returns cell for model and index path
    ///
    /// - Parameters:
    ///   - itemModel: model with data for cell.`AnyHashable`.
    ///   - indexPath: Index path of cell.`IndexPath`.
    /// - Returns: Dequeued collection cell. `UICollectionViewCell`, nullable
    func cell(
        forItemModel itemModel: AnyHashable,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionViewCell?

    /// Returns view section, kind of view and index path
    ///
    /// - Parameters:
    ///   - sectionContent: model section content.`SQSectionContent`.
    ///   - kind: kind of section view. `String`
    ///   - indexPath: Index path of cell.`IndexPath`.
    /// - Returns: Dequeued collection view. `UICollectionReusableView`, nullable
    func view(
        forSectionContent sectionContent: SQSectionContent,
        kind: String,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionReusableView?

    /// - Parameters:
    ///   - kind: kind of section view. `String`.
    /// - Returns: Dequeued collection view. `UICollectionReusableView`, nullable
    func globalView(
        forCollectionHeaderFooter kind: String
    ) -> UICollectionReusableView?

    /// - Parameters:
    ///   - class: type of view. `String`.
    func updateGlobalView<T: UICollectionReusableView>(
        forHeaderFooterView class: T.Type,
        handler: (_ reusableView: T) -> Void
    )
}

public extension SQListFactory {

    func view(
        forSectionContent sectionContent: SQSectionContent,
        kind: String,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionReusableView? {
        nil
    }

    func globalView(
        forCollectionHeaderFooter kind: String
    ) -> UICollectionReusableView? {
        nil
    }

    func updateGlobalView<T: UICollectionReusableView>(
        forHeaderFooterView class: T.Type,
        handler: (_ reusableView: T) -> Void
    ) { }
}
