//
//  File.swift
//  
//
//  Created by Виталий Баник on 25.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIStackView {
    
    /// True cleaning arranged subviews for UIStackView
    func removeAllArrangedSubviews() {
        let removedSubviews = self.base.arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.base.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
