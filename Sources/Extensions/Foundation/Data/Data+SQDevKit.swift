//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 11.08.2021.
//

import Foundation

public extension SQExtensions where Base == Data {

    /// Converts data to attributed string
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(
                data: self.base,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            print("error:", error)
            return nil
        }
    }

    /// Converts data to string
    var html2String: String? { self.html2AttributedString?.string }

    static func mockDataFromJSON(withName name: String) -> Data {
        guard let path = Bundle.main.path(forResource: name, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        else { return Data() }

        return data
    }
}

extension Data: SQExtensionsCompatible {}
