//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 16.08.2021.
//

import UIKit
import SQDifferenceKit

class InfiniteCollectionView: UICollectionView, DiffCollectionProtocol {
    
    var collectionView: UICollectionView! {
        return self
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        self.configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.configure()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.configure()
    }

// MARK: - Configure
    private func configure() {
        
    }
}
