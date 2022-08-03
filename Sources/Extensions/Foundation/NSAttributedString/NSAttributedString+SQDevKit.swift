//
//  File.swift
//  
//
//  Created by Виталий Баник on 26.03.2021.
//

import UIKit
import Foundation

public extension SQExtensions where Base: NSAttributedString {

    /// Set text color for all string and return NSAttributedString
    ///
    /// - Parameters:
    ///   - color: setted color.`UIColor`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setColor(_ color: UIColor?) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setColor(color)
    }
    
    /// Set text color for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - color: setted color.`UIColor`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setColor(forText textForAttribute: String,
                  withColor color: UIColor?,
                  caseSensitive: Bool = true,
                  onlyFirstMatch: Bool = false) -> NSAttributedString {
        
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setColor(forText: textForAttribute,
                         withColor: color,
                         caseSensitive: caseSensitive,
                         onlyFirstMatch: onlyFirstMatch)
    }

    /// Set font color for all string and return NSAttributedString
    ///
    /// - Parameters:
    ///   - font: setted font.`UIFont`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setFont(_ font: UIFont?) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setFont(font)

    }
    
    /// Set font color for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - font: setted font.`UIFont`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setFont(forText textForAttribute: String,
                 withFont font: UIFont?,
                 caseSensitive: Bool = true,
                 onlyFirstMatch: Bool = false) -> NSAttributedString {
        
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setFont(forText: textForAttribute,
                        withFont: font,
                        caseSensitive: caseSensitive,
                        onlyFirstMatch: onlyFirstMatch)
    }

    /// Set underscore for all string and return NSAttributedString
    ///
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setUnderscore() -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setUnderscore()
    }
    
    /// Set underscore for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting underscoring.`String`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setUnderscore(forText textForAttribute: String,
                       caseSensitive: Bool = true,
                       onlyFirstMatch: Bool = false) -> NSAttributedString {
        
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setUnderscore(forText: textForAttribute,
                              caseSensitive: caseSensitive,
                              onlyFirstMatch: onlyFirstMatch)
    }

    /// Set strikethrough for all string
    ///
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    @discardableResult
    func setStrikethrough() -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setStrikethrough()
    }

    /// Set strikethrough for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting strikethrough.`String`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    @discardableResult
    func setStrikethrough(forText textForAttribute: String,
                          caseSensitive: Bool = true,
                          onlyFirstMatch: Bool = false) -> NSMutableAttributedString {
        
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setStrikethrough(forText: textForAttribute,
                                 caseSensitive: caseSensitive,
                                 onlyFirstMatch: onlyFirstMatch)
    }

    /// Set line height for all string and return NSAttributedString
    ///
    /// - Parameters:
    ///   - lineHeight: setted line height.`CGFloat`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setLineHeight(_ lineHeight: CGFloat) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setLineHeight(lineHeight)
    }

    /// Set line height for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - lineHeight: setted line height.`CGFloat`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setLineHeight(forText textForAttribute: String,
                       withLineHeight lineHeight: CGFloat,
                       caseSensitive: Bool = true,
                       onlyFirstMatch: Bool = false) -> NSAttributedString {
        
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setLineHeight(forText: textForAttribute,
                              withLineHeight: lineHeight,
                              caseSensitive: caseSensitive,
                              onlyFirstMatch: onlyFirstMatch)
    }

    /// Set text alignment
    ///
    /// - Parameters:
    ///   - alignment: setted alignment.`NSTextAlignment`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setAlignment(_ alignment: NSTextAlignment) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setAlignment(alignment)
    }

    /// Set text alignment for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - alignment: setted alignment.`NSTextAlignment`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setAlignment(forText textForAttribute: String,
                      withAlignment alignment: NSTextAlignment,
                      caseSensitive: Bool = true,
                      onlyFirstMatch: Bool = false) -> NSAttributedString {
        
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setAlignment(forText: textForAttribute,
                             withAlignment: alignment,
                             caseSensitive: caseSensitive,
                             onlyFirstMatch: onlyFirstMatch)
    }

    /// Set line breaking mode for text
    ///
    /// - Parameters:
    ///   - lineBreakMode: setted line breaking mode.`NSLineBreakMode`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    @discardableResult
    func setLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setLineBreakMode(lineBreakMode)
    }

    /// Set line breaking mode for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting line breaking.`String`.
    ///   - lineBreakMode: setted line breaking mode.`NSLineBreakMode`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    @discardableResult
    func setLineBreakMode(forText textForAttribute: String,
                          withLineBreakMode lineBreakMode: NSLineBreakMode,
                          caseSensitive: Bool = true,
                          onlyFirstMatch: Bool = false) -> NSAttributedString {
        
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setLineBreakMode(forText: textForAttribute,
                                 withLineBreakMode: lineBreakMode,
                                 caseSensitive: caseSensitive,
                                 onlyFirstMatch: onlyFirstMatch)
    }


    /// Set line spacing
    ///
    /// - Parameters:
    ///   - spacing: setted line spacint.`NSTextAlignment`.
    @discardableResult
    func setLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setLineSpacing(spacing)
    }

    /// Return width of string
    /// - Parameters:
    ///   - height: height of string.`CGFloat`.
    func desiredWidth(withHeight height: CGFloat) -> CGFloat {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.desiredWidth(withHeight: height)
    }

    /// Return height of string
    /// - Parameters:
    ///   - width: width of string.`CGFloat`.
    func desiredHeight(withWidth width: CGFloat) -> CGFloat {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.desiredHeight(withWidth: width)
    }

    /// Return size to fit attributedString
    /// - Parameters:
    ///   - size: max size for string.`CGSize`.
    func desiredSize(forMaxSize size: CGSize) -> CGSize {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.desiredSize(forMaxSize: size)
    }
    
    /// Returns ranges of substring
    ///
    /// - Parameters:
    ///   - substring: substring for find.`String`.
    /// - Returns: Array of ranges for the found string. `[NSRange]`
    func ranges(of substring: String,
                caseSensitive: Bool = true) -> [NSRange] {
        
        return NSMutableAttributedString(attributedString: self.base).sq.ranges(of: substring,
                                                                                caseSensitive: caseSensitive)
    }
    
    /// Replace substring at image with NSTextAttachment
    ///
    /// - Parameters:
    ///   - textForReplace: substring for replace.`String`.
    ///   - image: image for replace.`UIImage?`.
    /// - Returns: String for image. `NSAttributedString`
    func replaceTextToImage(_ textForReplace: String, image: UIImage?) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.replaceTextToImage(textForReplace, image: image)
    }
}
