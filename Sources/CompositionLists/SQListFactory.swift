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
    ///   - modelRow: model with data for cell.`AnyHashable`.
    ///   - indexPath: Index path of cell.`IndexPath`.
    /// - Returns: Dequeued collection cell. `UICollectionViewCell`, nullable
    func cell(
        forModelRow modelRow: AnyHashable,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionViewCell?

    /// Returns view section, kind of view and index path
    ///
    /// - Parameters:
    ///   - modelSection: model section content.`SQSectionContent`.
    ///   - kind: kind of section view. `String`
    ///   - indexPath: Index path of cell.`IndexPath`.
    /// - Returns: Dequeued collection view. `UICollectionReusableView`, nullable
    func view(
        forModelSection modelSection: SQSectionContent,
        kind: String,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionReusableView?
}

public extension SQListFactory {

    func registerElements() {
        self.collectionView?.sq.registerClass(UICollectionViewCell.self)
    }

    func cell(
        forModelRow modelRow: AnyHashable,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionViewCell? {
        self.collectionView?.sq.dequeueReusableCell(
            UICollectionViewCell.self,
            indexPath: indexPath
        )
    }

    func view(
        forModelSection modelSection: SQSectionContent,
        kind: String,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionReusableView? {
        nil
    }
}
