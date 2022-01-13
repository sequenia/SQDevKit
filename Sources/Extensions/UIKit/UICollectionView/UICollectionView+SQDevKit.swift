//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

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
        if let specificIdentifier = identifier {
            cellIdentifier = specificIdentifier
        }

        self.base.register(T.self.sq.nib,
                           forCellWithReuseIdentifier: cellIdentifier)
    }

    /// Register cell with class in the collection view
    ///
    /// - Parameters:
    ///   - cellClass: class of cell
    ///   - identifier: optional reuse identifier for cell.  By default, for identifier will be used cell's class name `String`
    ///
    func registerClass<T: UICollectionViewCell>(_ cellClass: T.Type,
                                                identifier: String? = nil) {
        var cellIdentifier = T.self.sq.identifier
        if let specificIdentifier = identifier {
            cellIdentifier = specificIdentifier
        }
        self.base.register(T.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    /// Register cell with unique nib name
    ///
    /// - Parameters:
    ///   - nibName: nib name
    ///   - cellClass: class of cell
    func registerCellWithNibName(_ nibName: String) {
        let nib = UINib(nibName: nibName, bundle: Bundle(identifier: nibName))
        self.base.register(nib, forCellWithReuseIdentifier: nibName)
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
        if let specificIdentifier = identifier {
            cellIdentifier = specificIdentifier
        }

        return self.base.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                             for: indexPath) as? T
    }
    
    /// Dequeue cell at index path with unique nib name
    ///
    /// - Parameters:
    ///   - nibName: nib name
    ///   - cellClass: class of cell
    ///   - indexPath: index path of cell. `IndexPath`
    func dequeueReusableCellWithNibName<T: UICollectionViewCell>(_ nibName: String,
                                                                 _ cellClass: T.Type,
                                                                 indexPath: IndexPath? = nil) -> T? {
        guard let path = indexPath else { return nil }
        return self.base.dequeueReusableCell(withReuseIdentifier: nibName,
                                             for: path) as? T
    }

}

// MARK: - Work with supplementary views
public extension SQExtensions where Base: UICollectionView {

    /// Register suplementary xib-less view in collection
    ///
    /// - Parameters:
    ///   - view: class of view
    ///   - kind: kind of view. `String`
    ///   - identifier: optional reuse identifier for view.  By default, for identifier will be used cell's class name `String`
    func registerSupplementaryView<T: UICollectionReusableView>(
        _ viewClass: T.Type,
        viewOfKind kind: String,
        identifier: String? = nil
    ) {
        var viewIdentifier = T.self.sq.identifier
        if let specificIndentifer = identifier {
            viewIdentifier = specificIndentifer
        }

        self.base.register(
            T.self,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: viewIdentifier
        )
    }

    /// Dequeue suplementary view at index path
    ///
    /// - Parameters:
    ///   - view: class of view
    ///   - kind: kind of view. `String`
    ///   - indexPath: index path of view. `IndexPath`
    ///   - identifier: optional reuse identifier for view.  By default, for identifier will be used cell's class name `String`
    /// - Returns: supplementary view of collection
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        _ view: T.Type,
        ofKind kind: String,
        indexPath: IndexPath,
        identifier: String? = nil
    ) -> T? {
        var viewIdentifier = T.self.sq.identifier
        if let specificIndentifer = identifier {
            viewIdentifier = specificIndentifer
        }

        return self.base.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: viewIdentifier,
            for: indexPath
        ) as? T
    }
    
}

// MARK: - Utils
public extension SQExtensions where Base: UICollectionView {

    func currentPage(maxPageNumber: Int) -> Int {
        let contentOffset = Int(self.base.contentOffset.x)

        if contentOffset <= .zero { return .zero }

        if contentOffset >= Int(self.base.sq.maxContentOffset.x) { return maxPageNumber }

        let center = CGPoint(
            x: self.base.frame.width / 2.0,
            y: self.base.frame.minY + self.base.frame.height / 2.0
        )

        var minDistance: CGFloat = .greatestFiniteMagnitude
        var centerIndex: Int = .zero

        self.base.visibleCells.forEach { cell in
            guard let indexPath = self.base.indexPath(for: cell) else { return }

            let convertedCenter = self.base.convert(cell.center, to: self.base.superview)

            let distance = convertedCenter.sq.distance(to: center)
            if distance < minDistance {
                minDistance = distance
                centerIndex = indexPath.item
            }
        }

        return centerIndex
    }
}

public extension String {

    /// Default kind name for `UICollectionView` section header view
    static let collectionSectionHeader = "UICollectionElementKindSectionHeader"

    /// Default kind name for `UICollectionView` section footer view
    static let collectionSectionFooter = "UICollectionElementKindSectionFooter"
}
