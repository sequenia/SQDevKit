//
//  SQButtonStyle.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit

open class SQButtonStyle: SQStyle {

    public private(set) var contentInsets: UIEdgeInsets = .zero
    public private(set) var iconSpacing: CGFloat = .zero
    private var textStyles = [UIControl.State: SQFont]()
    private var textColors = [UIControl.State: UIColor]()
    private var backgroundColors = [UIControl.State: UIColor]()
    private var tintColors = [UIControl.State: UIColor]()
    private var borderColors = [UIControl.State: UIColor]()
    private var borderWidths = [UIControl.State: CGFloat]()
    private var cornerRadiuses = [UIControl.State: CGFloat]()
    

    @discardableResult
    open func contentInsets(_ contentInsets: UIEdgeInsets) -> Self {
        self.contentInsets = contentInsets
        return self
    }
    
    @discardableResult
    open func iconSpacing(_ iconSpacing: CGFloat) -> Self {
        self.iconSpacing = iconSpacing
        return self
    }

    @discardableResult
    open func textStyle(_ font: SQFont, forState state: UIControl.State = .normal) -> Self {
        self.textStyles[state] = font
        return self
    }

    open func textStyle(forState state: UIControl.State = .normal) -> SQFont? {
        self.textStyles[state] ?? self.textStyles[.normal]
    }

    @discardableResult
    open func textColor(_ color: UIColor?, forState state: UIControl.State = .normal) -> Self {
        if let textColor = color {
            self.textColors[state] = textColor
        }
        return self
    }

    open func textColor(forState state: UIControl.State = .normal) -> UIColor? {
        self.textColors[state] ?? self.textColors[.normal]
    }

    @discardableResult
    open func backgroundColor(_ color: UIColor?, forState state: UIControl.State = .normal) -> Self {
        if let bgColor = color {
            self.backgroundColors[state] = bgColor
        }
        return self
    }

    open func backgroundColor(forState state: UIControl.State = .normal) -> UIColor? {
        self.backgroundColors[state] ?? self.backgroundColors[.normal]
    }

    @discardableResult
    open func tintColor(_ color: UIColor?, forState state: UIControl.State = .normal) -> Self {
        if let tintColor = color {
            self.tintColors[state] = tintColor
        }
        return self
    }

    open func tintColor(forState state: UIControl.State = .normal) -> UIColor? {
        self.tintColors[state] ?? self.tintColors[.normal]
    }

    @discardableResult
    open func borderColor(_ color: UIColor?, forState state: UIControl.State = .normal) -> Self {
        if let borderColor = color {
            self.borderColors[state] = borderColor
        }
        return self
    }

    open func borderColor(forState state: UIControl.State = .normal) -> UIColor? {
        self.borderColors[state] ?? self.borderColors[.normal]
    }

    @discardableResult
    open func borderWidth(_ width: CGFloat, forState state: UIControl.State = .normal) -> Self {
        self.borderWidths[state] = width
        return self
    }

    open func borderWidth(forState state: UIControl.State = .normal) -> CGFloat {
        (self.borderWidths[state] ?? self.borderWidths[.normal]) ?? .zero
    }

    @discardableResult
    open func cornerRadius(_ radius: CGFloat, forState state: UIControl.State = .normal) -> Self {
        self.cornerRadiuses[state] = radius
        return self
    }

    open func cornerRadius(forState state: UIControl.State = .normal) -> CGFloat {
        (self.cornerRadiuses[state] ?? self.cornerRadiuses[.normal]) ?? .zero
    }

    open func attributes(forState state: UIControl.State) -> [NSAttributedString.Key: Any] {
        var attrs = self.attributes
        if let textStyle = self.textStyle(forState: state) {
            if let paragraphStyle = attrs[.paragraphStyle] as? NSParagraphStyle {

                let font = textStyle.font
                let lineHeight = textStyle.lineHeight

                let mutableParagraph = NSMutableParagraphStyle()
                mutableParagraph.setParagraphStyle(paragraphStyle)
                mutableParagraph.minimumLineHeight = lineHeight
                mutableParagraph.maximumLineHeight = lineHeight

                let adjustment = lineHeight > font.lineHeight ? 2.0 : 1.0
                let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / adjustment

                attrs[.baselineOffset] = baselineOffset
                attrs[.paragraphStyle] = mutableParagraph
            }

            if let letterSpacing = textStyle.letterSpacing {
                attrs[.kern] = letterSpacing
            }

            attrs[.font] = textStyle.font
        }

        return attrs
    }

    open func convertStringToAttributed(
        _ string: NSAttributedString,
        forState state: UIControl.State
    ) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(attributedString: string)
        mutableString.addAttributes(
            self.attributes(forState: state),
            range: NSRange(location: .zero, length: string.length)
        )

        return mutableString
    }
}
