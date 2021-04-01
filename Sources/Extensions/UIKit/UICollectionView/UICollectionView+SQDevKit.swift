//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension UICollectionView {

    /// Kind of supplementary view in collection
    enum SupplementaryViewKind: String {
        /// Header
        case header = "UICollectionElementKindSectionHeader"

        /// Footer
        case footer = "UICollectionElementKindSectionFooter"
    }
}

// MARK: - Work with cells
public extension SQExtensions where Base: UICollectionView {

    /// Register cell with class in the collection view
    ///
    /// - Parameters:
    ///   - cellClass: class of cell
    ///   - identifier: optional reuse identifier for cell.  By default, for identifier will be used cell's class name `String`
    ///
    /// - Precondition: Cell must have .xib-file and that name must be equal to cell's class
    func register<T: UICollectionViewCell>(_ cellClass: T.Type,
                                           identifier: String? = nil) {
        var cellIdentifier = T.self.sq.identifier
        if let specificIndentifer = identifier {
            cellIdentifier = specificIndentifer
        }

        self.base.register(T.self.sq.nib,
                           forCellWithReuseIdentifier: cellIdentifier)
    }

    /// Dequeue cell at index path
    ///
    /// - Parameters:
    ///   - cellClass: class of cell
    ///   - indexPath: index path of cell. `IndexPath`
    ///   - identifier: optional reuse identifier for cell.  By default, for identifier will be used cell's class name `String`
    /// - Returns: cell of collection
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type,
                                                      indexPath: IndexPath,
                                                      identifier: String? = nil) -> T? {
        var cellIdentifier = T.self.sq.identifier
        if let specificIndentifer = identifier {
            cellIdentifier = specificIndentifer
        }

        return self.base.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                             for: indexPath) as? T
    }

}

// MARK: - Work with supplementary views
public extension SQExtensions where Base: UICollectionView {

    /// Register suplementary view in collection
    ///
    /// - Parameters:
    ///   - view: class of view
    ///   - kind: kind of view. `UICollectionView.SupplementaryViewKind`
    ///   - identifier: optional reuse identifier for view.  By default, for identifier will be used cell's class name `String`
    /// - Precondition: View must have .xib-file and that name must be equal to view's class
    func registerHeaderFooter<T: UICollectionReusableView>(_ viewClass: T.Type,
                                                           viewOfKind kind: UICollectionView.SupplementaryViewKind,
                                                           identifier: String? = nil) {
        var viewIdentifier = T.self.sq.identifier
        if let specificIndentifer = identifier {
            viewIdentifier = specificIndentifer
        }

        self.base.register(T.self.sq.nib,
                           forSupplementaryViewOfKind: kind.rawValue,
                           withReuseIdentifier: viewIdentifier)
    }

    /// Dequeue suplementary view at index path
    ///
    /// - Parameters:
    ///   - view: class of view
    ///   - kind: kind of view. `UICollectionView.SupplementaryViewKind`
    ///   - indexPath: index path of view. `IndexPath`
    ///   - identifier: optional reuse identifier for view.  By default, for identifier will be used cell's class name `String`
    /// - Returns: supplementary view of collection
    func supplementaryView<T: UICollectionReusableView>(_ view: T.Type,
                                                        ofKind kind: UICollectionView.SupplementaryViewKind,
                                                        indexPath: IndexPath,
                                                        identifier: String? = nil) -> T? {
        var viewIdentifier = T.self.sq.identifier
        if let specificIndentifer = identifier {
            viewIdentifier = specificIndentifer
        }

        return self.base.dequeueReusableSupplementaryView(ofKind: kind.rawValue,
                                                          withReuseIdentifier: viewIdentifier,
                                                          for: indexPath) as? T
    }
    
}
