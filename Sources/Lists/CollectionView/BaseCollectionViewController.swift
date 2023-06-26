//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

// MARK: - Base Collection View
public protocol BaseCollectionView: AnyObject {

// MARK: - Variables
    var collectionView: UICollectionView! { get }
    var fabric: SQCollectionFabric! { get }

// MARK: - Methods
    func setupCollectionView()
    func setupFabric()
}
