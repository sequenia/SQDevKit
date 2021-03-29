//
//  File.swift
//  
//
//  Created by Виталий Баник on 25.03.2021.
//

import UIKit
import Foundation

public extension SQDevKit where Base: NSMutableAttributedString {
    
    /// Set text color for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - color: setted color.`UIColor`.
    @discardableResult
    func setColor(forText textForAttribute: String, withColor color: UIColor) -> NSMutableAttributedString {
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.foregroundColor, value: color, range: range)
        return self.base
    }
    
    /// Set font color for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - font: setted font.`UIFont`.
    @discardableResult
    func setFont(forText textForAttribute: String, withFont font: UIFont) -> NSMutableAttributedString{
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.font, value: font, range: range)
        return self.base
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
}
