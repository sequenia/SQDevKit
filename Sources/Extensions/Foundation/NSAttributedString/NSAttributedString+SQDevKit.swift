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
    func setColor(_ color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setColor(color)
    }
    
    /// Set text color for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - color: setted color.`UIColor`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setColor(forText textForAttribute: String, withColor color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setColor(forText: textForAttribute, withColor: color)
    }

    /// Set font color for all string and return NSAttributedString
    ///
    /// - Parameters:
    ///   - font: setted font.`UIFont`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setFont(_ font: UIFont) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setFont(font)

    }
    
    /// Set font color for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - font: setted font.`UIFont`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setFont(forText textForAttribute: String, withFont font: UIFont) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setFont(forText: textForAttribute, withFont: font)

    }

    /// Set underscore for all string and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setUnderscore() -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setUnderscore()
    }
    
    /// Set underscore for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setUnderscore(forText textForAttribute: String) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setUnderscore(forText: textForAttribute)
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
    func setLineHeight(forText textForAttribute: String, withLineHeight lineHeight: CGFloat) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setLineHeight(forText: textForAttribute, withLineHeight: lineHeight)
    }

    /// Set text alignment
    ///
    /// - Parameters:
    ///   - alignment: setted alignment.`NSTextAlignment`.
    func setAlignment(_ alignment: NSTextAlignment) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setAlignment(alignment)
    }

    /// Set text alignment for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - alignment: setted alignment.`NSTextAlignment`.
    func setAlignment(forText textForAttribute: String, withAlignment alignment: NSTextAlignment) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setAlignment(forText: textForAttribute, withAlignment: alignment)
    }

    /// Return height of string
    /// - Parameters:
    ///   - width: width of string.`CGFloat`.
    func desiredHeight(withWidth width: CGFloat) -> CGFloat {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.desiredHeight(withWidth: width)
    }
}
