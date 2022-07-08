//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 13.01.2022.
//

import UIKit

// MARK: - Associated keys
private struct SQListViewAssociatedKeys {

    static var sections: UInt8 = 0
    static var dataSource: UInt8 = 1
    static var factory: UInt8 = 2
}

// MARK: - Typealias
@available(iOS 13.0, *)
public typealias SQDataSource = UICollectionViewDiffableDataSource<SQSection, AnyHashable>

// MARK: - Protocol
@available(iOS 13.0, *)
/// Protocol, describing all things for draw list
public protocol SQListViewProtocol: AnyObject {

    /// Collection view that displayed list
    var collectionView: UICollectionView! { get set }

    /// Sections for displaying
    var sections: [SQSection] { get }

    /// Factory for generation collection views and cells
    var factory: SQListFactory! { get set }

    /// Data source for managing cells and views
    var dataSource: SQDataSource! { get }

    /// Reload collection view with new sections content
    ///
    /// - Parameters:
    ///   - content: new sections content.`[SQSectionContent]`.
    ///   - animated: need reload with animation.`Bool`.
    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool
    )

    /// Reload collection view with new sections content
    ///
    /// - Parameters:
    ///   - content: new sections content.`[SQSectionContent]`.
    ///   - animated: need reload with animation.`Bool`.
    ///   - completion: closure calls on finish reloading data.`(() -> Void)?`, can be nil
    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool,
        completion: (() -> Void)?
    )
}

// MARK: - Default implementation
@available(iOS 13.0, *)
public extension SQListViewProtocol {

    internal(set) var sections: [SQSection] {
        get {
            guard let value = objc_getAssociatedObject(self, &SQListViewAssociatedKeys.sections) as? [SQSection] else { return [] }

            return value
        }
        set {
            objc_setAssociatedObject(self, &SQListViewAssociatedKeys.sections, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var dataSource: SQDataSource! {
        if let dataSource = objc_getAssociatedObject(self, &SQListViewAssociatedKeys.dataSource) as? SQDataSource {
            return dataSource
        }

        let dataSource = SQDataSource(
            collectionView: self.collectionView,
            cellProvider: { [weak self] _, indexPath, item in
                self?.factory.cell(forItemModel: item, atIndexPath: indexPath)
            }
        )

        dataSource.supplementaryViewProvider = { [weak self] _, kind, indexPath in
            if let collectionHeaderFooter = self?.factory
                .globalView(forCollectionHeaderFooter: kind) {
                return collectionHeaderFooter
            }

            guard let sectionContent = self?.sections[safe: indexPath.section]?.content else { return nil }

            return self?.factory.view(
                forSectionContent: sectionContent,
                kind: kind,
                atIndexPath: indexPath
            )
        }
        objc_setAssociatedObject(self, &SQListViewAssociatedKeys.dataSource, dataSource, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return dataSource
    }

    var factory: SQListFactory! {
        get {
            guard let value = objc_getAssociatedObject(self, &SQListViewAssociatedKeys.factory) as? SQListFactory else { return nil }

            return value
        }
        set {
            objc_setAssociatedObject(self, &SQListViewAssociatedKeys.factory, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool
    ) {
        self.reloadData(withSectionsContent: content, animated: animated, completion: nil)
    }

    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool,
        completion: (() -> Void)?
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<SQSection, AnyHashable>()
        self.sections = content.map { SQSection($0) }
        self.sections.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(section.content.items)
        }
        self.dataSource.apply(
            snapshot,
            animatingDifferences: animated,
            completion: completion
        )
    }
}
