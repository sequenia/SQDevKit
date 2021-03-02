//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 02.03.2021.
//

import UIKit

// MARK: - VUPER Table View
public protocol VUPERTableView: VUPERView {
// MARK: - Actions
    func updateCells()
}

// MARK: - VUPER Table View - Default implementation
public extension VUPERTableView where Self: BaseTableView {

// MARK: - Actions
    func updateCells() {
        if #available(iOS 11.0, *) {
            self.tableView.performBatchUpdates {

            } completion: { (completion) in

            }
        } else {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}

