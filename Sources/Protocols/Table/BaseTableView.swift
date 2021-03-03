//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 02.03.2021.
//

import UIKit
import SQDifferenceKit

// MARK: - Base Table View
public protocol BaseTableView: class {

// MARK: - Variables
    var fabric: SQTableFabric! { get }
    var tableView: UITableView! { get }

// MARK: - Methods
    func setupTableView()
    func setupFabric()
}

