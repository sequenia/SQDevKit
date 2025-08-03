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
    public private(set) var baselineIsAllowed = true

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
            let baselineOffset = baselineIsAllowed
            ? (lineHeight - font.lineHeight) / 2.0 / adjustment
            : 0.0

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
    
    @discardableResult
    open func baselineIsAllowed(_ isAllowed: Bool) -> Self {
        self.baselineIsAllowed = isAllowed
        return self
    }
    
    override open func requiredWidth(
        forString string: String,
        height: CGFloat
    ) -> CGFloat {
        let constraintBox = CGSize(
            width: .greatestFiniteMagnitude,
            height: height
        )

        return self
            .attirubtedStringForCalculation(string: string)
            .boundingRect(
                with: constraintBox,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            .width
            .rounded(.up)
    }
    
    override open func requiredHeight(
        forString string: String,
        width: CGFloat
    ) -> CGFloat {
        let constraintBox = CGSize(
            width: width,
            height: .greatestFiniteMagnitude
        )

        return self.attirubtedStringForCalculation(string: string)
            .boundingRect(
                with: constraintBox,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            .height
            .rounded(.up)
    }
    
    internal func attirubtedStringForCalculation(
        string: String
    ) -> NSAttributedString {
        var newAttributedString = NSMutableAttributedString(string: string)
        self.attributes.forEach { attribute in
            if attribute.key == .paragraphStyle,
               let originalParagraphStyle = attribute.value as? NSParagraphStyle {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.setParagraphStyle(originalParagraphStyle)
                paragraphStyle.lineBreakMode = .byWordWrapping

                newAttributedString.addAttribute(attribute.key, value: paragraphStyle, range: NSRange(location: .zero, length: string.count))

                return
            }

            newAttributedString.addAttribute(attribute.key, value: attribute.value, range: NSRange(location: .zero, length: string.count))
        }
        
        return newAttributedString
    }
}
