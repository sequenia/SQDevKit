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
            self.setCornerRadius(newValue)
        }
    }

    /// Set corner radius for view
    ///
    /// - Parameters:
    ///   - cornerRadius: corner radius for view. `CGFloat`
    func setCornerRadius(_ cornerRadius: CGFloat) {
        self.base.layer.cornerRadius = cornerRadius
        self.base.clipsToBounds = true
    }

    /// Border width of view
    var borderWidth: CGFloat {
        get { self.base.layer.borderWidth }
        set { self.setBorderWidth(newValue) }
    }

    /// Set border's width for view
    ///
    /// - Parameters:
    ///   - borderWidth: border width for view. `CGFloat`
    func setBorderWidth(_ borderWidth: CGFloat) {
        self.base.layer.borderWidth = borderWidth
    }

    /// Border color of view
    var borderColor: UIColor? {
        get {
            guard let cgColor = self.base.layer.borderColor else { return nil }

            return UIColor(cgColor: cgColor)
        }
        set {
            self.setBorderColor(newValue)
        }
    }

    /// Set border's color for view
    ///
    /// - Parameters:
    ///   - borderColor: border color for view. `CGFloat`
    func setBorderColor(_ borderColor: UIColor?) {
        self.base.layer.borderColor = borderColor?.cgColor
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

    /// Added difference corner radius to view's corners
    /// - Parameters:
    ///   - topLeft: radius of top left corner. `CGFloat`
    ///   - topRight: radius of top right corner. `CGFloat`
    ///   - bottomLeft: radius of bottom left corner. `CGFloat`
    ///   - bottomRight: radius of bottom right corner. `CGFloat`
    func roundCorners(
        topLeft: CGFloat = .zero,
        topRight: CGFloat = .zero,
        bottomLeft: CGFloat = .zero,
        bottomRight: CGFloat = .zero
    ) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)

        let maskPath = UIBezierPath(
            shouldRoundRect: self.base.bounds,
            topLeftRadius: topLeftRadius,
            topRightRadius: topRightRadius,
            bottomLeftRadius: bottomLeftRadius,
            bottomRightRadius: bottomRightRadius
        )

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.base.layer.mask = shape
    }

}
