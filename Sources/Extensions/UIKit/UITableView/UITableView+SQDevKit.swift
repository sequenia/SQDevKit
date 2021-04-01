//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

// MARK: - Table Cells
public extension SQExtensions where Base: UITableView {

    /// Register cell with class in the table view
    ///
    /// - Parameters:
    ///   - cellClass: class of cell
    ///   - identifier: optional reuse identifier for cell.  By default, for identifier will be used cell's class name `String`
    ///
    /// - Precondition: Cell must have .xib-file and that name must be equal to cell's class
    func register<T: UITableViewCell>(_ cellClass: T.Type,
                                      identifier: String? = nil) {
        var cellIdentifier = T.self.sq.identifier
        if let specificIndentifer = identifier {
            cellIdentifier = specificIndentifer
        }

        self.base.register(T.self.sq.nib,
                           forCellReuseIdentifier: cellIdentifier)
    }

    /// Dequeue cell at index path
    ///
    /// - Parameters:
    ///   - cellClass: class of cell
    ///   - indexPath: index path of cell. `IndexPath`
    ///   - identifier: optional reuse identifier for cell.  By default, for identifier will be used cell's class name `String`
    /// - Returns: cell of table
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type,
                                                 indexPath: IndexPath? = nil,
                                                 identifier: String? = nil) -> T? {
        var cellIdentifier = T.self.sq.identifier
        if let specificIndentifer = identifier {
            cellIdentifier = specificIndentifer
        }

        guard let path = indexPath else {
            return self.base.dequeueReusableCell(withIdentifier: cellIdentifier) as? T
        }

        return self.base.dequeueReusableCell(withIdentifier: cellIdentifier,
                                             for: path) as? T
    }
}

// MARK: - Scrolling utils
public extension SQExtensions where Base: UITableView {

    /// Scroll table to section
    ///
    /// - Parameters:
    ///   - section: number of section. `Int`
    ///   - position: desired table's scroll position. ` UITableView.ScrollPosition`, by default - `.top`
    ///   - animated: `Bool`
    func scrollToSection(_ section: Int,
                         position: UITableView.ScrollPosition = .top,
                         animated: Bool) {
        if section >= self.base.numberOfSections {
            return
        }

        let indexPath = IndexPath(row: 0, section: section)

        if self.base.numberOfRows(inSection: section) > 0 {
            self.base.scrollToRow(at: indexPath, at: position, animated: animated)
        }
    }
}

// MARK: - Utils
public extension SQExtensions where Base: UITableView {

    /// Fill table's footer to table fill all screen content
    func adjustFooterToFill() {
        let tableView = self.base

        guard let tableFooterView = tableView.tableFooterView else { return }

        var topInset: CGFloat = .zero
        if #available(iOS 11.0, *) {
            topInset = tableView.adjustedContentInset.top
        }

        let minHeight = tableFooterView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let currentFooterHeight = tableFooterView.frame.height
        let fitHeight = tableView.frame.height - topInset - tableView.contentSize.height + currentFooterHeight

        let nextHeight = (fitHeight > minHeight) ? fitHeight : minHeight

        guard round(nextHeight) != round(currentFooterHeight) else { return }

        var frame = tableFooterView.frame
        frame.size.height = nextHeight
        tableFooterView.frame = frame
        tableView.tableFooterView = tableFooterView
    }
}
