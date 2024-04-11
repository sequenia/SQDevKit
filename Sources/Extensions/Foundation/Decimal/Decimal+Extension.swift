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
        maximumFractionDigits: Int = 2
    ) -> String {
        let formatter = NumberFormatter()
        
        formatter.decimalSeparator = ","
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        if let symbol = currencySymbol {
            formatter.currencySymbol = symbol
        }
        formatter.locale = Locale(identifier: langCode)
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.maximumSignificantDigits = 1000
        formatter.usesSignificantDigits = true

        return formatter.string(from: self.base as NSNumber) ?? ""
    }
}

extension Decimal: SQExtensionsCompatible {}
