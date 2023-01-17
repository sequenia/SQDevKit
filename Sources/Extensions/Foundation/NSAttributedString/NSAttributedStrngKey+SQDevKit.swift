//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 29.12.2022.
//

import UIKit

public extension Dictionary where Key == NSAttributedString.Key, Value: Any {

    var cssStyle: String {
        var styleAttributes = [String]()
        if let font = self[.font] as? UIFont {
            styleAttributes.append("font-size: \(font.pointSize)px")
            styleAttributes.append("font-family: \(font.fontName)")
        }
        if let paragraphStyle = self[.paragraphStyle] as? NSParagraphStyle {
            styleAttributes.append("line-height: \(paragraphStyle.maximumLineHeight)px")
        }
        if let letterSpacing = self[.kern] as? CGFloat {
            styleAttributes.append("letter-spacing: \(letterSpacing)px")
        }
        if let color = self[.foregroundColor] as? UIColor {
            styleAttributes.append("color: \(color.sq.hexString)")
        }
        return styleAttributes.joined(separator: ";\n")
    }
}
