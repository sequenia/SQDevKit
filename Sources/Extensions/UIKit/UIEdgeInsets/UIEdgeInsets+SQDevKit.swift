//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 14.09.2021.
//

import UIKit

public extension UIEdgeInsets {

    /// Create edge insets with top and bottom insets equals to parameter `vertical` and left and right equals to parameter `horizontal`
    ///
    /// - Parameters:
    ///   - horizontal: horizontal edge insets. `CGFloat`
    ///   - vertical: vertical edge insets. `CGFloat`
    convenience init(horizontal: CGFloat = .zero, vertical: CGFloat = .zero) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }
}

public extension SQExtensions where Base == UIEdgeInsets {

    /// Total vertical insets value
    var vertical: CGFloat {
        return self.base.top + self.base.bottom
    }

    /// Total horizontal insets value
    var horizontal: CGFloat {
        return self.base.left + self.base.right
    }
}

extension UIEdgeInsets: SQExtensionsCompatible {}
