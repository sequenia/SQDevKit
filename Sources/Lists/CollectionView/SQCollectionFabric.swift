//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit
import SQExtensions
import SQDifferenceKit

// MARK: - CollectionFabric
open class SQCollectionFabric: NSObject {

// MARK: - Properties
    open weak var collectionView: UICollectionView!

// MARK: - Inits
    public init(collectionView: UICollectionView) {
        super.init()

        self.collectionView = collectionView
        self.registerCells()
    }

// MARK: - Register Cells
    open func registerCells() {
        self.collectionView.sq.register(UICollectionViewCell.self)
    }

// MARK: - Methods
    open func cell(forModelRow modelRow: ModelRow,
                   atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    open func header(forModelSection modelSection: ModelView?,
                     atIndexPath indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }

    open func footer(forModelSection modelSection: ModelView?,
                     atIndexPath indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}

