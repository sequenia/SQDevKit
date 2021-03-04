//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension SQDevKit where Base: UITableViewCell {

    /// Force hide cell's separators
    func hideSeparators() {
        self.base.separatorInset = UIEdgeInsets(top: 0,
                                                left: UIScreen.main.bounds.width,
                                                bottom: 0,
                                                right: 0)
    }
}
