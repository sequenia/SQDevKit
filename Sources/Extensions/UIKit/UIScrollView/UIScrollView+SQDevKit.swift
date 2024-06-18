//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQExtensions where Base: UIScrollView {

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
    
    func scrollToTop(animated: Bool = false) {
        var topContentOffset: CGPoint
        if #available(iOS 11.0, *) {
            topContentOffset = CGPoint(
                x: -self.base.safeAreaInsets.left,
                y: -self.base.safeAreaInsets.top
            )
        } else {
            topContentOffset = CGPoint(
                x: -self.base.contentInset.left,
                y: -self.base.contentInset.top
            )
        }
            self.base.setContentOffset(topContentOffset, animated: animated)
        }
}
