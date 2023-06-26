//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 11.01.2022.
//

import Foundation

#if canImport(SQExtensions)
import SQExtensions
#endif

@propertyWrapper
public struct StoredValue<T: Codable> {

    public var wrappedValue: T? {
        get {
            UserDefaults.sq.get(forKey: self.key) ?? self.defaultValue
        }
        set {
            UserDefaults.sq.set(newValue, forKey: self.key)
        }
    }

    private let key: String
    private let defaultValue: T?

    public init(key: String, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
