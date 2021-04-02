//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit
import SQExtensions
import SQDifferenceKit

// MARK: - Table fabric
open class SQTableFabric: NSObject {

// MARK: - Properties
    open weak var tableView: UITableView?

// MARK: - Inits
    public init(tableView: UITableView) {
        super.init()

        self.tableView = tableView
        self.registerCells()
    }

// MARK: - Register cells
    open func registerCells() {
        self.tableView?.sq.register(UITableViewCell.self)
    }

// MARK: - Methods
    open func cell(forModelRow modelRow: ModelRow,
                   atIndexPath indexPath: IndexPath) -> UITableViewCell {
       return UITableViewCell()
    }

    open func header(forModelSection modelSection: ModelView?,
                     atSection section: Int) -> UIView? {
       guard modelSection != nil else { return nil }

       return UIView()
    }

    open func footer(forModelSection modelSection: ModelView?,
                     atSection section: Int) -> UIView? {
       guard modelSection != nil else { return nil }

       return UIView()
    }
}
