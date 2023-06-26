//
//  UIControl+Extensions.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit

extension UIControl.State: Hashable {

    public static let loading = UIControl.State(rawValue: 1 << 16)

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
