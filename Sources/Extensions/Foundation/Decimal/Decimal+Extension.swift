//
//  Decimal+Extension.swift
//  
//
//  Created by Nikolay Komissarov on 08.09.2023.
//

import Foundation

public extension SQExtensions where Base == Decimal {
    
    /// Converts Decimal to string with currency
    ///
    /// - Parameters:
    ///   - langCode: langCode (identifier) for initialize Locale object.`String`. Default `"ru_RU"`.
    ///   - maximumFractionDigits: The maximum number of digits after the decimal separator.`Int`.
    /// - Returns: formatted currency string `String`
    func stringCurrency(
        currencySymbol: String? = nil,
        langCode: String = "ru_RU",
        maximumFractionDigits: Int = 2,
        shouldAddTrailingZeroes: Bool = false
    ) -> String {
        let formatter = NumberFormatter()
        
        formatter.decimalSeparator = .separator
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.locale = Locale(identifier: langCode)
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.maximumSignificantDigits = 1000
        formatter.usesSignificantDigits = true
        
        guard let formattedString = formatter
            .string(from: self.base as NSNumber)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
        else {
            return ""
        }
        
        let components = formattedString.components(separatedBy: String.separator)
        if components.count < 2 {
            return [formattedString, currencySymbol]
                .compactMap { $0 }
                .joined(separator: " ")
        }

        let integerPart = components[0]
        let fractionPart = shouldAddTrailingZeroes ?
            components[1].padding(
                toLength: maximumFractionDigits,
                withPad: "0",
                startingAt: components[1].count - 1 ?? 0
            ) :
            components[1]

        let processedFormattedString = [integerPart, fractionPart]
            .compactMap { $0 }
            .joined(separator: .separator)
        
        return [processedFormattedString, currencySymbol]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}

extension Decimal: SQExtensionsCompatible {}

private extension String {
    
    static let separator = ","
}
