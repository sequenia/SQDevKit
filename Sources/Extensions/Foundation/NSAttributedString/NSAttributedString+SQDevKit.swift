//
//  File.swift
//  
//
//  Created by Виталий Баник on 26.03.2021.
//

import UIKit
import Foundation

public extension SQDevKit where Base: NSAttributedString {
    
    /// Set text color for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - color: setted color.`UIColor`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setColor(forText textForAttribute: String, withColor color: UIColor) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(attributedString: self.base)
        let range: NSRange = mutableString.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        mutableString.addAttribute(.foregroundColor, value: color, range: range)
        return NSAttributedString(attributedString: mutableString)
    }
    
    /// Set font color for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - font: setted font.`UIFont`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setFont(forText textForAttribute: String, withFont font: UIFont) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(attributedString: self.base)
        let range: NSRange = mutableString.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        mutableString.addAttribute(.font, value: font, range: range)
        return NSAttributedString(attributedString: mutableString)
    }
    
    /// Set underscore for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setUnderscore(forText textForAttribute: String) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(attributedString: self.base)
        let range: NSRange = mutableString.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        mutableString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
        return NSAttributedString(attributedString: mutableString)
    }
}
