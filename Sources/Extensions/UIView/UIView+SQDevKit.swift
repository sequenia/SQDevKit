//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIView {

    static var identifier: String {
        return String(describing: UIView.self.classForCoder())
    }

    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: Bundle(for: UIView.self))
    }

    static func instance() -> Self? {
        return UINib(nibName: self.identifier,
                     bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? Self
    }

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

    func blink() {
        self.base.alpha = 0.2
        UIView.animate(withDuration: 0.3) {
            self.base.alpha = 1.0
        }
    }
}

