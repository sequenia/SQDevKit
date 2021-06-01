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
