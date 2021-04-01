//
//  File.swift
//  
//
//  Created by Виталий Баник on 26.03.2021.
//

import UIKit
import Foundation

public extension SQExtensions where Base: NSAttributedString {
    
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
    
    /// Set underscore for substring and return NSAttributedString
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    /// - Returns: NSAttributedString object with setted parameters `NSAttributedString`
    func setUnderscore(forText textForAttribute: String) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self.base)
            .sq.setUnderscore(forText: textForAttribute)
    }
}
