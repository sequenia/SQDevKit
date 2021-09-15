//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 14.09.2021.
//

import UIKit

public extension SQExtensions where Base == UIEdgeInsets {

    var vertical: CGFloat {
        return self.base.top + self.base.bottom
    }

    var horizontal: CGFloat {
        return self.base.left + self.base.right
    }
}

extension UIEdgeInsets: SQExtensionsCompatible {}
