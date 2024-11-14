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
        case html(styles: String? = nil)
    }

    public lazy var style = ElementStyle(component: self)
    public lazy var placeholderStyle = SQTextStyle()

    public var textType: TextType = .plain
    
    private var textInsets: UIEdgeInsets {
        .init(
            top: self.style.textInsets.top,
            left: self.style.textInsets.left,
            bottom: self.style.textInsets.bottom,
            right: self.style.textInsets.right
        )
    }
    
    open var placeholder: String = "" {
        didSet {
            self.text = placeholder
            self.updateAttributedText()
        }
    }

    override open var text: String? {
        didSet {
            super.text = text
            
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
    
    public func setPlaceholderStyle() {
        self.text = placeholder

        self.font = self.placeholderStyle.font
        self.textColor = self.placeholderStyle.textColor
    }
    
    public func setTextStyle() {
        self.font = self.style.font
        self.textColor = self.style.textColor
        self.tintColor = self.style.cursorColor
        
        self.textContainerInset = textInsets
    }
    
    internal func updateBackground() {
        self.backgroundColor = self.style.backgroundColor(forState: .normal)
    }
    
    internal func updateBorders() {
        self.clipsToBounds = true
        self.layer.borderColor = self.style.borderColor(forState: .normal)?.cgColor
        self.layer.borderWidth = self.style.borderWidth(forState: .normal)
        self.layer.cornerRadius = self.style.cornerRadius(forState: .normal)
    }

    private func updateAttributedText() {
        switch self.textType {
        case .plain:
            let attributedString: NSAttributedString
            if let textViewAttributedString = self.attributedText {
                attributedString = textViewAttributedString
            } else {
                attributedString = NSAttributedString(string: self.text ?? "")
            }
            
            if self.text == self.placeholder {
                self.attributedText = self.placeholderStyle.convertStringToAttributed(attributedString)
            } else {
                self.attributedText = self.style.convertStringToAttributed(attributedString)
            }

        case .html(let styles):
            let fullStyles = """
            body {
                \(self.style.attributes.cssStyle)
            }
            \(styles ?? "")
            """
            self.attributedText = (self.text ?? "").sq.htmlAttributed(
                withStyles: fullStyles
            )
        }

        self.invalidateIntrinsicContentSize()
    }
}

extension SQTextView: StyledComponent {

    public func build() {
        self.font = self.style.font
        self.textColor = self.style.textColor
        self.tintColor = self.style.cursorColor
        
        self.textContainerInset = textInsets

        self.updateBackground()
        self.updateBorders()
        self.updateAttributedText()

        self.setNeedsDisplay()
    }

    public func resetStyle() {
        self.style = ElementStyle(component: self)
        self.placeholderStyle = SQTextStyle()
    }
}
