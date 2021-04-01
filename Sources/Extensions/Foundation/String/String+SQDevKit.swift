//
//  File.swift
//  
//
//  Created by Виталий Баник on 25.03.2021.
//

import UIKit

public extension SQExtensions where Base == String {
    
    /// Converts string with ISO format to date (example "2005-08-09T18:31:42")
    var toDate: Date? {
        let formatter = ISO8601DateFormatter()
        
        var options: ISO8601DateFormatter.Options = [
            .withInternetDateTime
        ]
        
        if #available(iOS 11.0, *) {
            options = [
                .withInternetDateTime,
                .withFractionalSeconds
            ]
        }
        
        formatter.formatOptions = options
        return formatter.date(from: self.base)
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
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(font.pointSize)px !important;" +
                "color: #\(color.sq.hexString) !important;" +
                "font-family: \(font.familyName), Helvetica !important;" +
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

}

extension String: SQExtensionsCompatible {}
