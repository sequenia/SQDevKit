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
    
    /// Radius for shadow of view
    var shadowRadius: CGFloat {
        get { self.layer.shadowRadius }
        set {
            self.layer.shadowRadius = newValue
            self.layer.masksToBounds = false
        }
    }
    
    /// Offset for shadow of view
    var shadowOffset: CGSize {
        get { self.layer.shadowOffset }
        set {
            self.layer.shadowOffset = newValue
            self.layer.masksToBounds = false
        }
    }
    
    /// Color for shadow of view
    var shadowColor: UIColor? {
        get {
            guard let cgColor = self.layer.shadowColor else { return nil }
            
            return UIColor(cgColor: cgColor)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
            self.layer.masksToBounds = false
        }
    }
    
    /// Opacity for shadow of view
    var shadowOpacity: Float {
        get { self.layer.shadowOpacity }
        set { self.layer.shadowOpacity = newValue }
    }
    
    /// Set shadow to view with parameters
    ///
    /// - Parameters:
    ///   - radius: radius for shadow of view. `CGFloat`
    ///   - offset: offset for shadow of view. `CGSize`
    ///   - color: color for shadow of view. `UIColor?`
    ///   - opacity: opacity for shadow of view. `Float`
    func setShadow(
        radius: CGFloat,
        offset: CGSize,
        color: UIColor?,
        opacity: Float
    ) {
        self.shadowRadius = radius
        self.shadowOffset = offset
        self.shadowColor = color
        self.shadowOpacity = opacity
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
    ///   - intensity: intensity for blure effect. `CGFloat`
    func addBlur(
        _ style: UIBlurEffect.Style = .light,
        color: UIColor = .clear,
        intensity: CGFloat = 1.0
    ) {
        let blurEffectView = CustomIntensityVisualEffectView(
            effect: UIBlurEffect(style: style),
            intensity: intensity
        )
        
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

/// Create visual effect view with given effect and its intensity
final class CustomIntensityVisualEffectView: UIVisualEffectView {
    
    private let theEffect: UIVisualEffect
    private let customIntensity: CGFloat
    private var animator: UIViewPropertyAnimator?
    
    init(
        effect: UIVisualEffect,
        intensity: CGFloat
    ) {
        theEffect = effect
        customIntensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
    
    deinit {
        animator?.stopAnimation(true)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        effect = nil
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(
            duration: 1,
            curve: .linear
        ) { [unowned self] in
            self.effect = theEffect
        }
        animator?.fractionComplete = customIntensity
    }
    
}
