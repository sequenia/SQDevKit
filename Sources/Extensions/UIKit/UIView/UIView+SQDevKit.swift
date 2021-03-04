//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIView {

    /// String identifier of view (class name)
    static var identifier: String {
        return String(describing: Base.self.classForCoder())
    }

    /// View's nib, based on view's class name
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: Bundle(for: Base.self))
    }

    /// Create view's example
    ///
    /// - Precondition: View must have .xib-file and that name must be equal to view's class
    /// - Returns: example of view
    static func instance() -> Self? {
        return UINib(nibName: self.identifier,
                     bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? Self
    }

    /// Load view from that's nib
    ///
    /// - Returns: `UIView`
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self.base))
        if let nibName = type(of: self.base).description().components(separatedBy: ".").last {
            let nib = UINib(nibName: nibName, bundle: bundle)
            if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
                return view
            }
        }
        return UIView()
    }


    /// Blink view with alpla
    ///
    /// - Parameters:
    ///   - alpha: alpha value. `CGFloat`, by default - `0.2`
    ///   - duration: blink animation's duration. `TimeInterval`, by default - `0.3`
    func blink(withAlpla alpha: CGFloat = 0.2,
               duration: TimeInterval = 0.3) {
        self.base.alpha = alpha
        UIView.animate(withDuration: duration) {
            self.base.alpha = 1.0
        }
    }
}

