//
//  File.swift
//
//
//  Created by Виталий Баник on 25.03.2021.
//

import UIKit

public extension SQExtensions where Base == String {

    var digits: String {
        return self.base.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }

    /// Returns string ready for use as URL (with percent encoding)
    var encodedUrl: String? {
        return self.base.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }

    /// Returns string with removed percent encoding
    var decodedUrl: String? {
        return self.base.removingPercentEncoding
    }

    /// Converts string to attributed string
    var attributedString: NSAttributedString {
        NSAttributedString(string: self.base)
    }

    /// Converts string with ISO 8601 format to date (example "2005-08-09T18:31:42")
    var toDate: Date? {
        ISO8601DateFormatter.sq.formatter.date(from: self.base)
    }

    /// Converts string into phone-call URL (example "tel://+79111111111")
    var toPhoneCallURL: URL? {
        let clearedString = self.base.components(separatedBy: .whitespacesAndNewlines).joined()
        return URL(string: "tel://\(clearedString)")
    }

    /// Converts string to date with selected format
    ///
    /// - Parameters:
    ///   - format: format for DateFormatter.`String`.
    /// - Returns: date created from formatted string. `Date`
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: self.base)
    }

    func htmlAttributed(withStyles styles: String) -> NSAttributedString? {
        let htmlCSSString = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style>
                    \(styles)
                </style>
            </head>
            <body>
                \(self.base)
            </body>
        </html>
        """
        guard let data = htmlCSSString.data(using: String.Encoding.utf8) else { return nil }

        return data.sq.html2AttributedString
    }

    /// Returns substring in NSRange
    ///
    /// - Parameters:
    ///   - range: range.`NSRaing`.
    /// - Returns: string from passed range. `String`
    func substring(with range: NSRange) -> String? {
        guard let range = Range(range, in: self.base) else { return nil }

        return String(self.base[range])
    }

    /// Returns ranges of substring
    ///
    /// - Parameters:
    ///   - substring: substring for find.`String`.
    /// - Returns: Array of ranges for the found string. `[Range]`
    func ranges(of substring: String,
                caseSensitive: Bool = true) -> [Range<Base.Index>] {

        var ranges: [Range<Base.Index>] = []
        while ranges.last.map({ $0.upperBound < self.base.endIndex }) ?? true,
              let range = self.base.range(of: substring,
                                          options: caseSensitive ? [] : [.caseInsensitive],
                                          range: (ranges.last?.upperBound ?? self.base.startIndex) ..< self.base.endIndex) {
            ranges.append(range)
        }

        return ranges
    }

    /// Returns string with capitalized first letter
    func capitalisingFirstLetter() -> String {
        return self.base.prefix(1).capitalized + self.base.dropFirst()
    }

    func localized(from bundle: Bundle = .main, fallbackBundle: Bundle) -> String {
        let localized = NSLocalizedString(self.base, bundle: bundle, comment: "")
        if localized != self.base {
            return localized
        }
        return NSLocalizedString(self.base, bundle: fallbackBundle, comment: "")
    }

    func withPrefix(
        _ prefix: String?,
        separator: String = "___"
    ) -> String {
        guard let prefix = prefix else { return self.base }
        
        if prefix.isEmpty { return self.base }

        return "\(prefix)\(separator)\(self.base)"
    }
}

extension String: SQExtensionsCompatible {}
