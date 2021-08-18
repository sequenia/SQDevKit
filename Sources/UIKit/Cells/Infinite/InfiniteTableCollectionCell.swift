//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 17.08.2021.
//

import UIKit
import SQDifferenceKit

open class InfiniteTableCollectionCell: BaseTableCollectionCell {

// MARK: - Properties
    public var infiniteModel: InfiniteCollectionModelRow? {
        self.model as? InfiniteCollectionModelRow
    }

    public var currentIndex: Int {
        let offset = self.collectionView.contentOffset.x
        let width = UIScreen.main.bounds.width
        let horizontalCenter = width / 2
        return Int(offset + horizontalCenter) / Int(width)
    }

    public var currentPage: Int {
        self.currentIndex % (self.infiniteModel?.originalCount ?? .zero)
    }

    override open var scrollPosition: CGPoint {
        get {
            CGPoint(x: .zero, y: self.currentIndex)
        }
        set {
            var currentIndex = Int(newValue.y)
            if currentIndex == .zero {
                currentIndex = (self.infiniteModel?.originalCount ?? .zero) * .infiniteCollectionDuplicates
            }

            self.collectionView.isPagingEnabled = false

            let newIndexPath = IndexPath(item: currentIndex, section: 0)
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: false)
                self.updateCurrentPage()
            }

            self.collectionView.isPagingEnabled = true
        }
    }

// MARK: - scrollViewDidScroll
    override open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)

        DispatchQueue.main.async {
            self.updateCurrentPage()
        }
    }

// MARK: - scrollViewDidEndDecelerating
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = self.currentIndex

        let contentCount = self.model?.sections.first?.elements.count ?? 2
        if currentIndex == 0 {
            self.collectionView.scrollToItem(
                at: IndexPath(
                    item: contentCount - 2,
                    section: 0
                ),
                at: .centeredHorizontally,
                animated: false
            )
        } else if currentIndex == contentCount - 1 {
            self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        }
    }

// MARK: - Update page control
    open func updateCurrentPage() {

    }
}

