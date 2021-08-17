//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import Foundation
import UIKit

public extension UIColor {

    /// Create color from red, green, blue and alpha components
    ///
    /// - Parameters:
    ///   - red: red component. `Int`
    ///   - green: green component. `Int`
    ///   - blue: blue component. `Int`
    ///   - alpha: alpha component. `CGFloat`. By default  - `1.0`
    ///
    /// - Precondition:
    ///   - Red, green and blue components must be greater or equal then 0 and less or equal then 255
    ///   - Alpha component must be greater or equal then 0 and less or equal then 1.0
    convenience init(withRed red: Int,
                     green: Int,
                     blue: Int,
                     alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component. Must be greater than or equal to 0 and less than or equal to 255")
        assert(green >= 0 && green <= 255, "Invalid green component. Must be greater than or equal to 0 and less than or equal to 255")
        assert(blue >= 0 && blue <= 255, "Invalid blue component. Must be greater than or equal to 0 and less than or equal to 255")
        assert(alpha >= 0.0 && alpha <= 1.0, "Invalid alpha component. Must be greater than or equal to 0.0 and less than or equal to 1.0")

        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }

    /// Create color from RGBA string
    ///
    /// - Parameters:
    ///   - rgba: hex-code of color
    ///
    /// - Precondition:rgba string must be matched one of the next patterns:
    ///   - 000
    ///   - #000
    ///   - 000000
    ///   - #000000
    ///   - 00000000
    ///   - #00000000
    convenience init?(withRGBA rgba: String) {
        var cleanString = self.base.replacingOccurrences(of: "#", with: "")
        guard cleanString.count == 3 ||
                cleanString.count == 6 ||
                cleanString.count == 8 else { return nil }
        
        if cleanString.count == 3 {
            cleanString = String(format: "%@%@%@%@%@%@",
                                 cleanString[0..<1],
                                 cleanString[0..<1],
                                 cleanString[1..<2],
                                 cleanString[1..<2],
                                 cleanString[2..<3],
                                 cleanString[2..<3])
        }

        if cleanString.count == 6 {
            cleanString += "ff"
        }
        
        cleanString = cleanString.lowercased()

        var red: CUnsignedLongLong   = 0
        var green: CUnsignedLongLong = 0
        var blue: CUnsignedLongLong  = 0
        var alpha: CUnsignedLongLong = 0

        Scanner(string: cleanString[0..<2]).scanHexInt64(&red)
        Scanner(string: cleanString[2..<4]).scanHexInt64(&green)
        Scanner(string: cleanString[4..<6]).scanHexInt64(&blue)
        Scanner(string: cleanString[6..<8]).scanHexInt64(&alpha)

        self.init(withRed: Int(red),
                  green: Int(green),
                  blue: Int(blue),
                  alpha: CGFloat(alpha) / 255.0)
    }
    
}

public extension SQExtensions where Base: UIColor {

    var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        self.base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgba: Int = (Int)(red * 255)<<16 | (Int)(green * 255)<<8 | (Int)(blue * 255)<<0

        return String(format: "#%06x", rgba)
    }
}

private extension String {

    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
