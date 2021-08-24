//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension SQExtensions where Base: UIView {

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
    static func instance() -> Base {
        if let nib = UINib(nibName: self.identifier,
                            bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? Base {
            
            return nib
        }
        
        fatalError("not found nib file!")
    }

    /// Corner radius of view
    var cornerRadius: CGFloat {
        get { self.base.layer.cornerRadius }
        set {
            self.base.layer.cornerRadius = newValue
            self.base.clipsToBounds = true
        }
    }

    /// Border width of view
    var borderWidth: CGFloat {
        get { self.base.layer.borderWidth }
        set { self.base.layer.borderWidth = newValue }
    }

    /// Border color of view
    var borderColor: UIColor? {
        get {
            guard let cgColor = self.base.layer.borderColor else { return nil }

            return UIColor(cgColor: cgColor)
        }
        set {
            self.base.layer.borderColor = newValue?.cgColor
        }
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
    
    /// Get array with all visible subview from view
    ///
    /// - Returns: array visible subviews `[UIView]`
    func getAllVisibleSubviews() -> [UIView] {
        var allSubviews = [UIView]()
        for subview in self.base.subviews {
            if !subview.isHidden {
                allSubviews.append(contentsOf: subview.sq.getAllVisibleSubviews())
            }
        }
        return allSubviews
    }
    
    /// Add blur effect for view with selected color
    ///
    /// - Parameters:
    ///   - effect: blur effect. `UIBlurEffect`
    ///   - color: color for blure. `UIColor`
    func addBlur(_ effect: UIBlurEffect, color: UIColor) {
        let blurEffectView = UIVisualEffectView(effect: effect)
        
        blurEffectView.backgroundColor = color
        blurEffectView.layer.masksToBounds = true
        blurEffectView.layer.cornerRadius = self.base.layer.cornerRadius
        blurEffectView.frame = self.base.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.base.insertSubview(blurEffectView, at: .zero)
    }
    
    /// Remove blur effect from view
    func removeBlur() {
        if let effectView = self.base.subviews.first(where: { $0 is UIVisualEffectView }) as? UIVisualEffectView,
           effectView.effect is UIBlurEffect {
            effectView.removeFromSuperview()
        }
    }

}
