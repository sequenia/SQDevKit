//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit
import SQDifferenceKit

// MARK: - Base Collection View
@objc public protocol BaseCollectionView where Self: UIViewController {

// MARK: - Variables
    var collectionView: UICollectionView! { get }

    var fabric: SQCollectionFabric! { get }

// MARK: - Methods
    func setupTableView()
    func setupFabric()
}

// MARK: - Base Collection View - Default implementation
public extension BaseCollectionView where Self: UICollectionViewDataSource,
                                          Self: UICollectionViewDelegate {

// MARK: - Methods
    func setupTableView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.setupFabric()
    }
}

// MARK: - Base Collection View - Data Source
public extension BaseCollectionView where Self: UICollectionViewDataSource,
                                          Self: DiffCollectionProtocol {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.data[section].elements.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.data[indexPath.section]
        let row = section.elements[indexPath.row]

        return self.fabric.cell(forModelRow: row, atIndexPath: indexPath)
    }
}

// MARK: - Base Collection View - Collection Delegate
public extension BaseCollectionView where Self: UICollectionViewDelegate,
                                          Self: DiffCollectionProtocol {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return self.fabric.header(forModelSection: self.data[indexPath.section].model.header,
                                      atIndexPath: indexPath)

        case UICollectionView.elementKindSectionFooter:
            return self.fabric.footer(forModelSection: self.data[indexPath.section].model.footer,
                                      atIndexPath: indexPath)

        default:
            assert(false, "Invalid element type")
        }

        return UICollectionReusableView()
    }
}

// MARK: - Base Collection View - Collection Cell Delegate
public extension BaseCollectionView where Self: CollectionCellDelegate,
                                          Self: DiffCollectionProtocol {

    func saveScrollPosition(_ position: CGPoint,
                            forModel model: CollectionModelRow?) {
        guard let model = model,
              let sectionIndex = self.data.firstIndex(where: { $0.elements.contains(where: { $0.differenceIdentifier == model.differenceIdentifier }) }) else { return }

        let key = self.cacheKey(forModel: model, inSection: sectionIndex)
        self.storeScrollPosition(position, forKey: key)
    }
}
