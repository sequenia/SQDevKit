//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 11.01.2022.
//

import Foundation

// MARK: - UserDefaults
public extension SQExtensions where Base: UserDefaults {

    /// Save decodable object in standard user defaults
    ///
    /// - Parameters:
    ///   - value: object for saving.`T`.
    ///   - forKey: key for saving.`String`.
    static func set<T>(_ value: T, forKey key: String) where T: Encodable {

        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }

        UserDefaults.standard.synchronize()
    }

    /// Return decodable object from standard user defaults
    ///
    /// - Parameters:
    ///   - forKey: key for executing object.`String`.
    /// - Returns:
    ///   - saved object `T`.
    static func get<T>(forKey key: String) -> T? where T: Decodable {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data,
              let decodedData = try? JSONDecoder().decode(T.self, from: data) else { return nil }

        return decodedData
    }
}

