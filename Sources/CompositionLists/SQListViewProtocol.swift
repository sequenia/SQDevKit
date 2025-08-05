//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 13.01.2022.
//

import UIKit

#if canImport(SQExtensions)
import SQExtensions
import SQEntities
#endif

public enum SQListViewContentOffsetUpdateMode {
    case auto
    case reset
    case setOffset(contentOffset: CGPoint)
}

// MARK: - Associated keys
private struct SQListViewAssociatedKeys {

    static var sections: UInt8   = 0
    static var dataSource: UInt8 = 1
    static var factory: UInt8    = 2
    static var provider: UInt8   = 3
}

// MARK: - Protocol
/// Protocol, describing all things for draw list
@available(iOS 13.0, *)
public protocol SQListViewProtocol: AnyObject {

    /// Collection view that displayed list
    var collectionView: UICollectionView! { get set }

    /// Sections for displaying
    var sections: [SQSection] { get }

    /// Factory for generation sections for content
    var provider: SQListProvider! { get set }

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
    ///   - keepContentOffsetUpdateMode: mode for updating contentOffser.`SQListViewContentOffsetUpdateMode`.
    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool,
        contentOffsetUpdateMode: SQListViewContentOffsetUpdateMode
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

    /// Reload collection view with new sections content
    ///
    /// - Parameters:
    ///   - content: new sections content.`[SQSectionContent]`.
    ///   - animated: need reload with animation.`Bool`.
    ///   - completion: closure calls on finish reloading data.`(() -> Void)?`, can be nil
    ///   - keepContentOffset: should keep content offset after reload.`Bool`.
    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool,
        contentOffsetUpdateMode: SQListViewContentOffsetUpdateMode,
        completion: (() -> Void)?
    )

    /// Reloads empty data set if it exists
    func reloadEmptyData()
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
                let sectionContent = self?.sections[safe: indexPath.section]?.content

                return self?.factory.cell(
                    forItemModel: item,
                    inSection: sectionContent,
                    atIndexPath: indexPath
                )
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

    var provider: SQListProvider! {
        get {
            guard let value = objc_getAssociatedObject(self, &SQListViewAssociatedKeys.provider) as? SQListProvider else { return nil }

            return value
        }
        set {
            objc_setAssociatedObject(self, &SQListViewAssociatedKeys.provider, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
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
        self.reloadData(
            withSectionsContent: content,
            animated: animated,
            contentOffsetUpdateMode: .auto,
            completion: nil
        )
    }
    
    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool,
        contentOffsetUpdateMode: SQListViewContentOffsetUpdateMode
    ) {
        self.reloadData(
            withSectionsContent: content,
            animated: animated,
            contentOffsetUpdateMode: contentOffsetUpdateMode,
            completion: nil
        )
    }
    
    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool,
        completion: (() -> Void)?
    ) {
        self.reloadData(
            withSectionsContent: content,
            animated: animated,
            contentOffsetUpdateMode: .auto,
            completion: completion
        )
    }

    func reloadData(
        withSectionsContent content: [SQSectionContent],
        animated: Bool,
        contentOffsetUpdateMode: SQListViewContentOffsetUpdateMode,
        completion: (() -> Void)?
    ) {
        var newSnapshot = NSDiffableDataSourceSnapshot<SQSection, AnyHashable>()

        self.sections = content.map { SQSection($0) }
        self.sections.forEach { section in
            newSnapshot.appendSections([section])
            newSnapshot.appendItems(section.content.items)
        }
        
        switch contentOffsetUpdateMode {
        case .auto, .reset:
            break

        case .setOffset(let contentOffset):
            self.collectionView.contentOffset = contentOffset
        }

        var previousContentOffset: CGPoint = .zero
        if !animated {
            UIView.setAnimationsEnabled(false)
            previousContentOffset = self.collectionView.contentOffset
        }

        self.dataSource.apply(
            newSnapshot,
            animatingDifferences: animated,
            completion: {
                CATransaction.begin()
                if !animated {
                    CATransaction.setDisableActions(true)
                }
                self.collectionView.setNeedsLayout()
                CATransaction.commit()

                if animated {
                    completion?()
                    self.reloadEmptyData()
                    return
                }
                
                UIView.setAnimationsEnabled(true)
                
                switch contentOffsetUpdateMode {
                case .auto:
                    break
                    
                case .reset:
                    self.collectionView.contentOffset = .zero

                case .setOffset:
                    self.collectionView.contentOffset = .init(
                        x: min(
                            self.collectionView.sq.maxContentOffset.x,
                            previousContentOffset.x
                        ),
                        y: min(
                            self.collectionView.sq.maxContentOffset.y,
                            previousContentOffset.y
                        )
                    )
                }
                
                self.reloadEmptyData()
                completion?()
            }
        )
    }

    func reloadEmptyData() {}
}
