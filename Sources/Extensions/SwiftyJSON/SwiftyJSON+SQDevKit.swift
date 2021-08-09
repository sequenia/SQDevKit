//
//  SwiftyJSON+SQDevKit.swift
//  
//
//  Created by Olga Lidman on 12.05.2021.
//

import Foundation
import SwiftyJSON

public extension SQExtensions where Base == JSON {
    
// MARK: - Identifier
    /// Returns string identifier in JSON of passed field
    ///
    /// - Parameters:
    ///   - field: field for getting identifier.`String`. Default value == `id`
    /// - Returns: string identifier. `String`
    func identifier(fromField field: String = "id") -> String? {
        if let stringValue = self.base[field].string { return stringValue }
        
        if let intValue = self.base[field].int { return "\(intValue)" }
        
        return nil
    }
    
// MARK: - String
    var clearString: String? {
        get {
            return self.base.string?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        set {
            self.base.object = newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? NSNull()
        }
    }
}
