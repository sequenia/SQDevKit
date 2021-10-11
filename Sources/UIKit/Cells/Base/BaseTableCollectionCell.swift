//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 11.08.2021.
//

import UIKit
import SQDifferenceKit
import DifferenceKit

#if canImport(SQLists)
import SQLists
#endif

open class BaseTableCollectionCell: UITableViewCell,
                                    CollectionCell,
                                    DiffCollectionProtocol,
                                    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

// MARK: - Properties
    public var model: CollectionModelRow? {
        didSet {
            (self.model?.sections ?? []).forEach { self.appendOrReplaceSection($0) }
        }
    }

    public weak var collectionDelegate: CollectionCellDelegate?
    open var fabric: SQCollectionFabric!

    open var scrollPosition: CGPoint {
        get {
            self.collectionView.contentOffset
        }
        set {
            self.collectionView.setContentOffset(newValue, animated: false)
        }
    }

// MARK: - Outlet
    @IBOutlet public weak var collectionView: UICollectionView!
    @IBOutlet public weak var heightCollectionConstraint: NSLayoutConstraint!

// MARK: - Life Cycle
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
        self.setupCollectionView()
    }

// MARK: - Bind model
    @discardableResult
    open func bind(
        model: CollectionModelRow,
        delegate: CollectionCellDelegate?
    ) -> Self {
        self.model = model
        self.collectionDelegate = delegate

        self.reloadAnimated(false)

        return self
    }

// MARK: - Configures
    open func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.initFabric()
    }

    open func initFabric() {
        assertionFailure("not init fabric")
    }

    open func sizeCell(_ forModel: ModelRow) -> CGSize {
        assertionFailure("instance size cell")
        return .zero
    }

// MARK: - UICollectionViewDataSource
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.data[section].elements.count
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = self.data[indexPath.section]
        let row = section.elements[indexPath.row]

        return self.fabric.cell(forModelRow: row, atIndexPath: indexPath)
    }

// MARK: - UICollectionViewDelegate
    open func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
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

    open func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        self.collectionDelegate?.collectionModel(
            self.model,
            willShowModelRow: self.data[indexPath.section].elements[indexPath.row],
            inSection: self.data[indexPath.section].model
        )
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        self.collectionDelegate?.collectionModel(
            self.model,
            didSelectModel: self.data[indexPath.section].elements[indexPath.row],
            inSection: self.data[indexPath.section].model
        )
    }

// MARK: - UICollectionViewDelegateFlowLayout
    open func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let model = self.data[indexPath.section].elements[indexPath.row]
        return self.sizeCell(model)
    }

// MARK: - UIScrollViewDelegate
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging || scrollView.isDecelerating {
            self.collectionDelegate?.saveScrollPosition(
                scrollView.contentOffset,
                forModel: self.model
            )
        }
    }
}
