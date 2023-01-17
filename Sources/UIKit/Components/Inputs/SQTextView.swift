//
//  SQTextView.swift
//  UIComponents
//
//  Created by Ivan Mikhailovskii on 28.10.2022.
//

import UIKit
import SQExtensions

open class SQTextView: UITextView {

    public typealias ElementStyle = SQInputStyle

    public enum TextType {
        case plain
        case html(styles: String)
    }

    public lazy var style = ElementStyle(component: self)
    public lazy var placeholderStyle = SQTextStyle()

    public var textType: TextType = .plain

    override open var text: String? {
        didSet {
            self.updateAttributedText()
        }
    }

    override open var selectedTextRange: UITextRange? {
        get {
            self.isEditable ? super.selectedTextRange : nil
        }
        set {
            if !self.isEditable { return }

            super.selectedTextRange = newValue
        }
    }

    @discardableResult
    public func style(_ style: ElementStyle) -> ElementStyle {
        self.style = style
        return style
    }

    override open func gestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        if self.isEditable {
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }

        if gestureRecognizer is UIPanGestureRecognizer {
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        if let tapGestureRecognizer = gestureRecognizer as? UITapGestureRecognizer,
            tapGestureRecognizer.numberOfTapsRequired == 1 {
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        if let longPressGestureRecognizer = gestureRecognizer as? UILongPressGestureRecognizer,
            longPressGestureRecognizer.minimumPressDuration < 0.325 {
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        gestureRecognizer.isEnabled = false
        return false
    }

    private func updateAttributedText() {
        if self.isEditable { return }

        switch self.textType {
        case .plain:
            let attributedString: NSAttributedString
            if let textViewAttributedString = self.attributedText {
                attributedString = textViewAttributedString
            } else {
                attributedString = NSAttributedString(string: self.text ?? "")
            }

            self.attributedText = self.style.convertStringToAttributed(
                attributedString
            )

        case .html(let styles):
            self.attributedText = (self.text ?? "")
                    .sq.htmlAttributed(withStyles: styles)
        }

        self.invalidateIntrinsicContentSize()
    }
}

extension SQTextView: StyledComponent {

    public func build() {
        self.font = self.style.font
        self.textColor = self.style.textColor
        self.tintColor = self.style.cursorColor

        self.updateAttributedText()

        self.setNeedsDisplay()
    }

    public func resetStyle() {
        self.style = ElementStyle(component: self)
        self.placeholderStyle = SQTextStyle()
    }
}
