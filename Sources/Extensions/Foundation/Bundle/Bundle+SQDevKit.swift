//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 22.12.2021.
//
import Foundation

public extension SQExtensions where Base: Bundle {

    static func stringPropertyForKey(_ key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key.sq.capitalisingFirstLetter()) as? String
    }

    static func boolPropertyForKey(_ key: String) -> Bool? {
        guard let stringProperty = self.stringPropertyForKey(key) else { return nil }
        return Bool(stringProperty)
    }

    static func integerPropertyForKey(_ key: String) -> Int? {
        guard let stringProperty = self.stringPropertyForKey(key) else { return nil }

        return Int(stringProperty)
    }

    static func doublePropertyForKey(_ key: String) -> Double? {
        guard let stringProperty = self.stringPropertyForKey(key) else { return nil }

        return Double(stringProperty)
    }
    
    var displayName: String? {
        let infoDictionary = self.base.localizedInfoDictionary ?? self.base.infoDictionary
        
        return (infoDictionary?["CFBundleDisplayName"] as? String) ??
            infoDictionary?["CFBundleName"] as? String
    }
    
    var releaseVersionNumber: String? {
        return self.base.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return self.base.infoDictionary?["CFBundleVersion"] as? String
    }
    
    var fullVersionName: String? {
        guard let releaseVersionNumber = self.releaseVersionNumber,
              let buildVersionNumber = self.buildVersionNumber else { return nil }
        
        return "\(releaseVersionNumber) (\(buildVersionNumber))"
    }
}
