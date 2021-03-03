//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit
import SQDifferenceKit

// MARK: - Base Collection View
public protocol BaseCollectionView: class {

// MARK: - Variables
    var collectionView: UICollectionView! { get }
    var fabric: SQCollectionFabric! { get }

// MARK: - Methods
    func setupCollectionView()
    func setupFabric()
}
