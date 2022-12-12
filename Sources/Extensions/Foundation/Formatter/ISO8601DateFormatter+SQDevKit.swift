//
//  ISO8601DateFormatter.swift
//  
//
//  Created by Semen Kologrivov on 29.06.2021.
//

import Foundation

public extension SQExtensions where Base == ISO8601DateFormatter {

    /// Formatter for ISO8601
    static var formatter: ISO8601DateFormatter {
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

        return formatter
    }
}
