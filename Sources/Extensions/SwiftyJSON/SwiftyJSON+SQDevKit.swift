//
//  SwiftyJSON+SQDevKit.swift
//  
//
//  Created by Olga Lidman on 12.05.2021.
//

import Foundation
import SwiftyJSON
import UIKit

public extension SQExtensions where Base == JSON {
    
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

    /// Returns bool value in JSON of passed field. Also processing alternatives like `0`,` 1`, `"0"`, `"1"`, `"true"`, `"false"`
    ///
    /// - Parameters:
    ///   - field: field for getting identifier.`String`
    /// - Returns: bool value. `Bool`
    func bool(fromField field: String) -> Bool {
        if let value = self.base[field].bool { return value }

        if let intValue = self.base[field].int,
           intValue != 0 {
            return true
        }

        if let stringValue = self.base[field].string {
            if let intValue = Int(stringValue),
               intValue != 0 {
                return true
            }

            return stringValue == "true"
        }

        return false
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

// MARK: - CGFLoat
    var cgFloat: CGFloat? {
        get {
            if let value = base.number?.floatValue {
                return CGFloat(value)
            }
            return nil
        }
        set {
            if let newValue = newValue {
                base.object = NSNumber(value: newValue)
            } else {
                base.object = NSNull()
            }
        }
    }
}
