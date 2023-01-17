//
//  SQTextField.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit

open class SQTextField: UITextField {

    public typealias ElementStyle = SQInputStyle

    public lazy var style = ElementStyle(component: self)
        .lineHeightIsAllowed(false)

    public lazy var placeholderStyle = SQTextStyle()

    override open var isEnabled: Bool {
        didSet {
            self.updateText()
            self.updateBorders()
        }
    }

    override open var text: String? {
        didSet {
            self.updateText()
        }
    }

    override open var placeholder: String? {
        didSet {
            self.updatePlaceholder()
        }
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.style.textInsets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.style.textInsets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.style.textInsets)
    }

    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.style.textInsets))
    }

    @discardableResult
    public func style(_ style: ElementStyle) -> ElementStyle {
        self.style = style
        self.style.component = self
        return style
    }

    internal func updateBorders() {
        self.layer.borderColor = self.style.borderColor(forState: self.state)?.cgColor
        self.layer.borderWidth = self.style.borerWidth(forState: self.state)
    }

    internal func updateText() {
        self.defaultTextAttributes = [:]

        if let strikethroughStyle = self.style.strikethroughStyle {
            self.defaultTextAttributes[.strikethroughStyle] = strikethroughStyle
        }

        if let underlineStyle = self.style.underlineStyle {
            self.defaultTextAttributes[.underlineStyle] = underlineStyle
        }

        if let letterSpacing = self.style.letterSpacing {
            self.defaultTextAttributes[.kern] = letterSpacing
        }

        if let color = self.style.textColor(forState: self.state) ?? self.textColor {
            self.defaultTextAttributes[.foregroundColor] = color
        }

        if let font = self.style.font {
            self.defaultTextAttributes[.font] = font
        }

        if let alignment = self.style.textAlignment {
            self.textAlignment = alignment
        }

    }

    internal func updatePlaceholder() {
        let attributedString: NSAttributedString
        if let labelAttributedText = self.attributedPlaceholder {
            attributedString = labelAttributedText
        } else {
            attributedString = NSAttributedString(string: self.placeholder ?? "")
        }

        self.attributedPlaceholder = self.placeholderStyle
            .convertStringToAttributed(
                attributedString
            )
    }
}

extension SQTextField: StyledComponent {

    public func build() {
        self.tintColor = self.style.cursorColor

        self.updateText()
        self.updatePlaceholder()
        self.updateBorders()

        self.setNeedsDisplay()
    }

    public func resetStyle() {
        self.style = ElementStyle(component: self)
            .lineHeightIsAllowed(false)

        self.placeholderStyle = SQTextStyle()
            .lineHeightIsAllowed(false)
    }
}
