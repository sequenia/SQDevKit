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
    ///   - textForAttribute: substring for setting color.`String`.
    ///   - color: setted color.`UIColor`.
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    /// Set font color for substring
    ///
    /// - Parameters:
    ///   - textForAttribute: substring for setting color.`String`.
    ///   - font: setted font.`UIFont`.
    func setFontForText(textForAttribute: String, withFont font: UIFont) {
        let range: NSRange = self.base.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.base.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
}
