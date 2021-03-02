//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension SQDevKit where Base: UICollectionView {

    func register<T: UICollectionViewCell>(_ cellClass: T.Type,
                                           identifier: String? = nil) {
        self.base.register(T.self.sq.nib,
                           forCellWithReuseIdentifier: identifier != nil ? identifier ?? "" : T.self.sq.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type,
                                                      indexPath: IndexPath,
                                                      identifier: String? = nil) -> T? {
        return self.base.dequeueReusableCell(withReuseIdentifier: identifier != nil ? identifier ?? "" : T.self.sq.identifier,
                                             for: indexPath) as? T
    }

    func registerHeaderFooter<T: UICollectionReusableView>(_ viewClass: T.Type,
                                                           viewOfKind kind: String) {
        self.base.register(T.self.sq.nib,
                           forSupplementaryViewOfKind: kind,
                           withReuseIdentifier: T.self.sq.identifier)
    }

    func supplementaryView<T: UICollectionReusableView>(_ view: T.Type,
                                                        ofKind kind: String,
                                                        indexPath: IndexPath) -> T? {
        return self.base.dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: T.self.sq.identifier,
                                                          for: indexPath) as? T
    }
    
}
