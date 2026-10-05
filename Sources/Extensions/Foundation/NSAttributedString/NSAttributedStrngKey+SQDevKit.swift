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
            if font.fontName.hasPrefix(".") || font.familyName.hasPrefix(".") {
                styleAttributes.append("font-family: -apple-system")
                if let weight = font.CSSWeight {
                    styleAttributes.append("font-weight: \(weight)")
                }
            } else {
                styleAttributes.append("font-family: \(font.fontName)")
            }
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

private extension UIFont {

    /// UIFont.Weight → CSS-вес (100...900), ближайшее совпадение по трейтам.
    var CSSWeight: Int? {
        guard let traits = self.fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any],
              let raw = traits[.weight] as? CGFloat else { return nil }

        let table: [(UIFont.Weight, Int)] = [
            (.ultraLight, 100), (.thin, 200), (.light, 300), (.regular, 400),
            (.medium, 500), (.semibold, 600), (.bold, 700), (.heavy, 800), (.black, 900)
        ]

        return table.min { abs($0.0.rawValue - raw) < abs($1.0.rawValue - raw) }?.1
    }
}
