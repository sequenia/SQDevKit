//
//  File.swift
//  
//
//  Created by Виталий Баник on 25.03.2021.
//

import UIKit

public extension SQExtensions where Base == String {

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
    
    /// Generating a NSAttributedString from a raw string with html markup
    ///
    /// - Parameters:
    ///   - with: base font class. `UIFont`.
    ///   - color: base font color. `UIColor`.
    /// - Returns: NSAttributedString with the passed attributes
    func htmlAttributed(with font: UIFont, color: UIColor) -> NSAttributedString? {
        let htmlCSSString = "<style>" +
            "html *" +
            "{" +
            "font-size: \(font.pointSize)px !important;" +
            "color: #\(color.sq.hexString) !important;" +
            "font-family: \(font.familyName), Helvetica !important;" +
            "text-overflow: ellipsis;" +
            "}</style> \(self)"
        
        guard let data = htmlCSSString.data(using: String.Encoding.utf8) else { return nil }

        return data.sq.html2AttributedString
    }
    
    /// Generating a NSAttributedString from a raw string with html markup
    ///
    /// - Parameters:
    ///   - family: base font family. `String`.
    ///   - size: base font size. `CGFloat`.
    ///   - color: base font color. `UIColor`.
    /// - Returns: NSAttributedString with the passed attributes
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)px !important;" +
                "color: #\(color.sq.hexString) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
                "text-overflow: ellipsis;" +
                "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            var dict: NSDictionary?
            dict = NSMutableDictionary()
            
            return try NSAttributedString(data: data,
                                          options: [
                                                .documentType: NSAttributedString.DocumentType.html,
                                                .characterEncoding: String.Encoding.utf8.rawValue
                                          ],
                                          documentAttributes: &dict)
        } catch {
            print("htmlAttributed error: ", error)
            return nil
        }
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

}

extension String: SQExtensionsCompatible {}
