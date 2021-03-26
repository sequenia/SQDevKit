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
    func setColor(forText textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.foregroundColor, value: color, range: range)
    }
    
    /// Set font color for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    ///   - font: setted font.`UIFont`.
    func setFont(forText textForAttribute: String, withFont font: UIFont) {
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.font, value: font, range: range)
    }
    
    /// Set underscore for substring
    ///
    /// - Parameters:
    ///   - forText: substring for setting color.`String`.
    func setUnderscore(forText textForAttribute: String) {
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
    }
}
