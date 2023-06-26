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
    func setColor(forText textForAttribute: String,
                  withColor color: UIColor?,
                  caseSensitive: Bool = true,
                  onlyFirstMatch: Bool = false) -> NSMutableAttributedString {
        
        guard let color = color,
              !textForAttribute.isEmpty else { return self.base }
        
        for range in self.ranges(of: textForAttribute,
                                 caseSensitive: caseSensitive) {
            
            self.base.addAttribute(.foregroundColor,
                                   value: color,
                                   range: range)
            
            if onlyFirstMatch { break }
        }
        
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
    func setFont(forText textForAttribute: String,
                 withFont font: UIFont?,
                 caseSensitive: Bool = true,
                 onlyFirstMatch: Bool = false) -> NSMutableAttributedString {
        
        guard let font = font,
              !textForAttribute.isEmpty else { return self.base }
        
        for range in self.ranges(of: textForAttribute,
                                 caseSensitive: caseSensitive) {
            
            self.base.addAttribute(.font,
                                   value: font,
                                   range: range)
            
            if onlyFirstMatch { break }
        }
        
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
    func setUnderscore(forText textForAttribute: String,
                       caseSensitive: Bool = true,
                       onlyFirstMatch: Bool = false) -> NSMutableAttributedString {
        
        if textForAttribute.isEmpty { return self.base }

        for range in self.ranges(of: textForAttribute,
                                 caseSensitive: caseSensitive) {
            
            self.base.addAttribute(.underlineStyle,
                                   value: NSUnderlineStyle.thick.rawValue,
                                   range: range)
            
            if onlyFirstMatch { break }
        }
        
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
    func setStrikethrough(forText textForAttribute: String,
                          caseSensitive: Bool = true,
                          onlyFirstMatch: Bool = false) -> NSMutableAttributedString {
        
        if textForAttribute.isEmpty { return self.base }

        for range in self.ranges(of: textForAttribute,
                                 caseSensitive: caseSensitive) {
            
            self.base.addAttribute(.strikethroughStyle,
                                   value: NSUnderlineStyle.single.rawValue,
                                   range: range)
            
            if onlyFirstMatch { break }
        }
        
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
    func setLineHeight(forText textForAttribute: String,
                       withLineHeight lineHeight: CGFloat,
                       caseSensitive: Bool = true,
                       onlyFirstMatch: Bool = false) -> NSMutableAttributedString {
        
        if textForAttribute.isEmpty { return self.base }

        for var range in self.ranges(of: textForAttribute,
                                     caseSensitive: caseSensitive) {
            
            guard let font = self.base.attributes(at: 0, effectiveRange: &range)[.font] as? UIFont else { return self.base }

            let paragraphAttributes = self.base.attributes(at: 0, effectiveRange: &range)[.paragraphStyle] as? NSParagraphStyle
            let paragraph = (paragraphAttributes?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()

            let lineHeight: CGFloat = ((100.0 * lineHeight) / font.lineHeight) / 100.0
            paragraph.lineHeightMultiple = lineHeight

            self.base.addAttribute(.paragraphStyle, value: paragraph, range: range)
            
            if onlyFirstMatch { break }
        }

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
    func setAlignment(forText textForAttribute: String,
                      withAlignment alignment: NSTextAlignment,
                      caseSensitive: Bool = true,
                      onlyFirstMatch: Bool = false) -> NSMutableAttributedString {
        
        if textForAttribute.isEmpty { return self.base }
        
        for var range in self.ranges(of: textForAttribute,
                                     caseSensitive: caseSensitive) {
            
            let paragraphAttributes = self.base.attributes(at: 0, effectiveRange: &range)[.paragraphStyle] as? NSParagraphStyle
            let paragraph = (paragraphAttributes?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()

            paragraph.alignment = alignment

            self.base.addAttribute(.paragraphStyle, value: paragraph, range: range)
            
            if onlyFirstMatch { break }
        }
        
        return self.base
    }

    /// Set line breaking mode for text
    ///
    /// - Parameters:
    ///   - lineBreakMode: setted line breaking mode.`NSLineBreakMode`.
    @discardableResult
    func setLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> NSMutableAttributedString {
        return self.base.sq.setLineBreakMode(forText: self.base.string, withLineBreakMode: lineBreakMode)
    }

    /// Set line breaking mode for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting line breaking.`String`.
    ///   - lineBreakMode: setted line breaking mode.`NSLineBreakMode`.
    @discardableResult
    func setLineBreakMode(forText textForAttribute: String,
                          withLineBreakMode lineBreakMode: NSLineBreakMode,
                          caseSensitive: Bool = true,
                          onlyFirstMatch: Bool = false) -> NSMutableAttributedString {

        if textForAttribute.isEmpty { return self.base }

        for var range in self.ranges(of: textForAttribute,
                                     caseSensitive: caseSensitive) {

            let paragraphAttributes = self.base.attributes(at: 0, effectiveRange: &range)[.paragraphStyle] as? NSParagraphStyle
            let paragraph = (paragraphAttributes?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()

            paragraph.lineBreakMode = lineBreakMode

            self.base.addAttribute(.paragraphStyle, value: paragraph, range: range)
            
            if onlyFirstMatch { break }
        }

        return self.base
    }

    /// Set line spacing
    ///
    /// - Parameters:
    ///   - spacing: setted line spacint.`NSTextAlignment`.
    @discardableResult
    func setLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        if self.base.string.isEmpty { return self.base }
        
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
        self.desiredSize(
            forMaxSize: CGSize(
                width: .greatestFiniteMagnitude,
                height: height
            )
        ).width
    }

    /// Return height of string
    /// - Parameters:
    ///   - width: width of string.`CGFloat`.
    func desiredHeight(withWidth width: CGFloat) -> CGFloat {
        self.desiredSize(
            forMaxSize: CGSize(
                width: width,
                height: .greatestFiniteMagnitude
            )
        ).height
    }

    /// Return size to fit attributedString
    /// - Parameters:
    ///   - size: max size for string.`CGSize`.
    func desiredSize(forMaxSize size: CGSize) -> CGSize {
        let textStorage = NSTextStorage(attributedString: self.base)

        let boundingRect = CGRect(origin: .zero, size: size)

        let textContainer = NSTextContainer(size: size)
        textContainer.lineFragmentPadding = 0

        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)

        textStorage.addLayoutManager(layoutManager)

        layoutManager.glyphRange(
            forBoundingRect: boundingRect,
            in: textContainer
        )

        let rect = layoutManager.usedRect(for: textContainer)

        return rect.integral.size
    }
    
    /// Returns ranges of substring
    ///
    /// - Parameters:
    ///   - substring: substring for find.`String`.
    /// - Returns: Array of ranges for the found string. `[NSRange]`
    func ranges(of substring: String,
                caseSensitive: Bool = true) -> [NSRange] {
        
        let stringRanges = self.base.string.sq.ranges(of: substring,
                                                      caseSensitive: caseSensitive)
        
        return stringRanges.map { NSRange($0, in: self.base.string) }
    }
    
    /// Replace substring at image with NSTextAttachment
    ///
    /// - Parameters:
    ///   - textForReplace: substring for replace.`String`.
    ///   - image: image for replace.`UIImage?`.
    /// - Returns: String for image. `NSAttributedString`
    @discardableResult
    func replaceTextToImage(_ textForReplace: String, image: UIImage?) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
                             
        let imageString = NSAttributedString(attachment: imageAttachment)
        let range = self.base.mutableString.range(of: textForReplace)
        self.base.replaceCharacters(in: range, with: imageString)
        
        return self.base
    }

}
