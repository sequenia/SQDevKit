//
//  File.swift
//  
//
//  Created by Виталий Баник on 25.03.2021.
//

import UIKit
import Foundation

public extension SQExtensions where Base: NSMutableAttributedString {

    /// Set text color for all string
    ///
    /// - Parameters:
    ///   - color: setted color.`UIColor`.
    @discardableResult
    func setColor(_ color: UIColor?) -> NSMutableAttributedString {
        return self.base.sq.setColor(forText: self.base.string, withColor: color)
    }
    
    /// Set text color for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - color: setted color.`UIColor`.
    @discardableResult
    func setColor(forText textForAttribute: String, withColor color: UIColor?) -> NSMutableAttributedString {
        guard let color = color else { return self.base }

        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.foregroundColor, value: color, range: range)
        return self.base
    }

    /// Set font color for all string
    ///
    /// - Parameters:
    ///   - font: setted font.`UIFont`.
    @discardableResult
    func setFont(_ font: UIFont?) -> NSMutableAttributedString {
        return self.base.sq.setFont(forText: self.base.string, withFont: font)
    }
    
    /// Set font color for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - font: setted font.`UIFont`.
    @discardableResult
    func setFont(forText textForAttribute: String, withFont font: UIFont?) -> NSMutableAttributedString{
        guard let font = font else { return self.base }
        
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.font, value: font, range: range)
        return self.base
    }

    /// Set underscore for all string
    ///
    @discardableResult
    func setUnderscore() -> NSMutableAttributedString {
        return self.base.sq.setUnderscore(forText: self.base.string)
    }
    
    /// Set underscore for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    @discardableResult
    func setUnderscore(forText textForAttribute: String) -> NSMutableAttributedString {
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
        return self.base
    }

    /// Set strikethrough for all string
    ///
    @discardableResult
    func setStrikethrough() -> NSMutableAttributedString {
        return self.base.sq.setStrikethrough(forText: self.base.string)
    }

    /// Set strikethrough for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting strikethrough.`String`.
    @discardableResult
    func setStrikethrough(forText textForAttribute: String) -> NSMutableAttributedString {
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        return self.base
    }

    /// Set line height for all string
    ///
    /// - Parameters:
    ///   - lineHeight: setted line height.`CGFloat`.
    @discardableResult
    func setLineHeight(_ lineHeight: CGFloat) -> NSMutableAttributedString {
        return self.base.sq.setLineHeight(forText: self.base.string, withLineHeight: lineHeight)
    }

    /// Set underscore for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - lineHeight: setted line height.`CGFloat`.
    @discardableResult
    func setLineHeight(forText textForAttribute: String, withLineHeight lineHeight: CGFloat) -> NSMutableAttributedString {
        var range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        guard let font = self.base.attributes(at: 0, effectiveRange: &range)[.font] as? UIFont else { return self.base }

        let paragraphAttributes = self.base.attributes(at: 0, effectiveRange: &range)[.paragraphStyle] as? NSParagraphStyle
        let paragraph = (paragraphAttributes?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()

        let lineHeight: CGFloat = ((100.0 * lineHeight) / font.lineHeight) / 100.0
        paragraph.lineHeightMultiple = lineHeight

        self.base.addAttribute(.paragraphStyle, value: paragraph, range: range)
        return self.base
    }

    /// Set text alignment
    ///
    /// - Parameters:
    ///   - alignment: setted alignment.`NSTextAlignment`.
    @discardableResult
    func setAlignment(_ alignment: NSTextAlignment) -> NSMutableAttributedString {
        return self.base.sq.setAlignment(forText: self.base.string, withAlignment: alignment)
    }

    /// Set text alignment for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - alignment: setted alignment.`NSTextAlignment`.
    @discardableResult
    func setAlignment(forText textForAttribute: String, withAlignment alignment: NSTextAlignment) -> NSMutableAttributedString {
        var range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        let paragraphAttributes = self.base.attributes(at: 0, effectiveRange: &range)[.paragraphStyle] as? NSParagraphStyle
        let paragraph = (paragraphAttributes?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()

        paragraph.alignment = alignment

        self.base.addAttribute(.paragraphStyle, value: paragraph, range: range)
        return self.base
    }

    /// Set line spacing
    ///
    /// - Parameters:
    ///   - spacing: setted line spacint.`NSTextAlignment`.
    @discardableResult
    func setLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        var range: NSRange = self.base.mutableString.range(of: self.base.string, options: .caseInsensitive)

        let paragraphAttributes = self.base.attributes(at: 0, effectiveRange: &range)[.paragraphStyle] as? NSParagraphStyle
        let paragraph = (paragraphAttributes?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()

        paragraph.lineSpacing = spacing

        self.base.addAttribute(.paragraphStyle, value: paragraph, range: range)
        return self.base
    }


    /// Return width of string
    /// - Parameters:
    ///   - height: height of string.`CGFloat`.
    func desiredWidth(withHeight height: CGFloat) -> CGFloat {
        var range: NSRange = self.base.mutableString.range(of: self.base.string, options: .caseInsensitive)

        return (self.base.string as NSString).size(
            withAttributes: self.base.attributes(at: 0, effectiveRange: &range)
        )
            .width.rounded(.up)
    }

    /// Return height of string
    /// - Parameters:
    ///   - width: width of string.`CGFloat`.
    func desiredHeight(withWidth width: CGFloat) -> CGFloat {
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        let rect = self.base.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).integral
        return rect.height
    }

}
