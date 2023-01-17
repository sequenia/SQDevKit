//
//  SQTextStyle.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit

open class SQTextStyle: SQStyle {

    public private(set) var font: UIFont?

    public private(set) var lineHeight: CGFloat?
    public private(set) var letterSpacing: CGFloat?

    public private(set) var textColor: UIColor?

    public private(set) var lineHeightIsAllowed = true

    override open var attributes: [NSAttributedString.Key: Any] {
        var attrs = super.attributes
        if let paragraphStyle = attrs[.paragraphStyle] as? NSParagraphStyle,
           let lineHeight = self.lineHeight,
           let font = self.font,
           self.lineHeightIsAllowed {

            let mutableParagraph = NSMutableParagraphStyle()
            mutableParagraph.setParagraphStyle(paragraphStyle)
            mutableParagraph.minimumLineHeight = lineHeight
            mutableParagraph.maximumLineHeight = lineHeight

            let adjustment = lineHeight > font.lineHeight ? 2.0 : 1.0
            let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / adjustment

            attrs[.baselineOffset] = baselineOffset
            attrs[.paragraphStyle] = mutableParagraph
        }

        if let letterSpacing = self.letterSpacing {
            attrs[.kern] = letterSpacing
        }

        if let font = self.font {
            attrs[.font] = font
        }

        if let textColor = self.textColor {
            attrs[.foregroundColor] = textColor
        }

        return attrs
    }

    @discardableResult
    open func textStyle(_ style: SQFont) -> Self {
        self.font = style.font
        self.letterSpacing = style.letterSpacing
        self.lineHeight = style.lineHeight

        return self
    }

    @discardableResult
    open func textColor(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    open func lineHeightIsAllowed(_ isAllowed: Bool) -> Self {
        self.lineHeightIsAllowed = isAllowed
        return self
    }
}
