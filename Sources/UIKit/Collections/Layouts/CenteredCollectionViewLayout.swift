//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 20.08.2021.
//

import UIKit

open class CenteredCollectionViewLayout: UICollectionViewFlowLayout {

    override open func prepare() {
        guard let collectionView = self.collectionView else { return }

        var verticalInsets: CGFloat = .zero
        var horizontalInsets: CGFloat = .zero

        if #available(iOS 11.0, *) {
            verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
            horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        }

        self.sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)

        super.prepare()
    }
}
