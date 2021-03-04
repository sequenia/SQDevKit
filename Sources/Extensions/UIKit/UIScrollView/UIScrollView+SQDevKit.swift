//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIScrollView {

    /// Minimum available content offset
    var minContentOffset: CGPoint {
        CGPoint(x: -self.base.contentInset.left,
                y: -self.base.contentInset.top)
    }

    /// Maximum available content offset
    var maxContentOffset: CGPoint {
        CGPoint(x: self.base.contentSize.width  - self.base.bounds.width  + self.base.contentInset.right,
                y: self.base.contentSize.height - self.base.bounds.height + self.base.contentInset.bottom)
    }
}
