//
//  SQTextField.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit
import SQExtensions

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

    private var clearButtonWidth: CGFloat {
        guard let clearButtonImage = self.style.clearButtonImage else { return .zero }

        return clearButtonImage.size.width +
            2 * self.style.textInsets.right
    }

    private var textInsets: UIEdgeInsets {
        .init(
            top: self.style.textInsets.top,
            left: self.style.textInsets.left,
            bottom: self.style.textInsets.bottom,
            right: max(self.style.textInsets.right, self.clearButtonWidth)
        )
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.textInsets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.textInsets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.textInsets)
    }

    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.textInsets))
    }

    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return .init(
            x: bounds.width - self.clearButtonWidth,
            y: .zero,
            width: self.clearButtonWidth,
            height: bounds.height
        )
    }

    open func setClearButtonVisibility(_ isVisible: Bool) {
        if self.style.clearButtonImage == nil || (self.text?.isEmpty ?? true) {
            self.rightViewMode = .never
            return
        }

        self.rightViewMode = isVisible ? .always : .never
    }

    internal func updateBackground() {
        self.background = .sq.create(
            withColor: self.style.backgroundColor(forState: .normal)
        )
        self.disabledBackground = .sq.create(
            withColor: self.style.backgroundColor(forState: .disabled)
        )
    }

    internal func updateBorders() {
        self.layer.borderColor = self.style.borderColor(forState: self.state)?.cgColor
        self.layer.borderWidth = self.style.borderWidth(forState: self.state)
        self.layer.cornerRadius = self.style.cornerRadius(forState: self.state)
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
        self.updateBackground()
        self.updatePlaceholder()
        self.updateBorders()

        if let image = self.style.clearButtonImage {
            let button = UIButton()
            button.setImage(image, for: .normal)
            button.addAction(
                .init(
                    handler: { [weak self] _ in
                        guard let self = self else { return }
                        
                        if !(self.delegate?.textFieldShouldClear?(self) ?? false) { return }
                        self.text = ""
                        self.sendActions(for: .editingChanged)
                    }
                ),
                for: .touchUpInside
            )
            button.sq.setBackgroundColor(
                self.style.backgroundColor(forState: .normal),
                forState: .normal
            )
            button.sq.setBackgroundColor(
                self.style.backgroundColor(forState: .disabled),
                forState: .disabled
            )
            self.rightView = button
        }

        self.setNeedsDisplay()
    }

    public func resetStyle() {
        self.style = ElementStyle(component: self)
            .lineHeightIsAllowed(false)

        self.placeholderStyle = SQTextStyle()
            .lineHeightIsAllowed(false)
    }
}
