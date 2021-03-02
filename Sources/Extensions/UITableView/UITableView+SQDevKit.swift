//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension SQDevKit where Base: UITableView {

    func register<T: UITableViewCell>(_ cellClass: T.Type,
                                      identifier: String? = nil) {
        self.base.register(T.self.sq.nib,
                           forCellReuseIdentifier: identifier != nil ? identifier ?? "" : T.self.sq.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type,
                                                 indexPath: IndexPath? = nil,
                                                 identifier: String? = nil) -> T? {
        guard let path = indexPath else {
            return self.base.dequeueReusableCell(withIdentifier: identifier != nil ? identifier ?? "" : T.self.sq.identifier) as? T
        }
        return self.base.dequeueReusableCell(withIdentifier: identifier != nil ? identifier ?? "" : T.self.sq.identifier,
                                             for: path) as? T
    }

    func scrollToSection(_ section: Int, animated: Bool) {
        self.scrollToSection(section,
                             position: .top,
                             animated: animated)
    }

    func scrollToSection(_ section: Int,
                         position: UITableView.ScrollPosition,
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
