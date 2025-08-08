//
//  File.swift
//  
//
//  Created by Семен Кологривов on 23.08.2024.
//

import Foundation
import OSLog

public struct PlistParserError: Error {

    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}

public class PListParser {
    
    private var plistName: String
    private var plistContent: [String: Any]
    private var logger = Logger()

    public init(plistName: String = "Info") throws {
        guard let plistPath = Bundle.main.path(forResource: plistName, ofType: "plist"),
              let content = NSDictionary(contentsOfFile: plistPath) as? [String: Any] else {

            throw PlistParserError(message: "Unable to find \(plistName).plist in resources")
        }

        self.plistName = plistName
        self.plistContent = content
    }
    
    public func string(
        forKey key: String,
        nestedIn dictionaryName: String? = nil
    ) throws -> String {
        let targetDictionary = try self.getTargetDictionary(name: dictionaryName)
        
        guard let value = targetDictionary[key] as? String else {
            let keyPath = self.keyPath(key, nestedIn: dictionaryName)
            throw PlistParserError(
                message: "Unable to find key \(keyPath) in \(self.plistName).plist"
            )
        }
        
        return value
    }
    
    public func stringArray(
        forKey key: String,
        nestedIn dictionaryName: String? = nil
    ) throws -> [String] {
        let targetDictionary = try self.getTargetDictionary(name: dictionaryName)
        
        guard let value = targetDictionary[key] as? [String] else {
            let keyPath = self.keyPath(key, nestedIn: dictionaryName)
            throw PlistParserError(
                message: "Unable to find key \(keyPath) in \(self.plistName).plist"
            )
        }
        
        return value
    }
    
    public func bool(
        forKey key: String,
        nestedIn dictionaryName: String? = nil
    ) throws -> Bool {
        let targetDictionary = try self.getTargetDictionary(name: dictionaryName)

        if let value = targetDictionary[key] as? Bool {
            return value
        }

        let stringValue = try self.string(forKey: key, nestedIn: dictionaryName).lowercased()
        
        return stringValue == "true" || stringValue == "yes" || stringValue == "1"
    }
    
    public func int(
        forKey key: String,
        nestedIn dictionaryName: String? = nil
    ) throws -> Int {
        let targetDictionary = try self.getTargetDictionary(name: dictionaryName)

        if let value = targetDictionary[key] as? Int {
            return value
        }

        let stringValue = try self.string(forKey: key, nestedIn: dictionaryName)
        let keyPath = self.keyPath(key, nestedIn: dictionaryName)
        
        guard let intValue = Int(stringValue) else {
            throw PlistParserError(
                message: "Unable to parse integer value from key \(keyPath) in \(self.plistName).plist"
            )
        }
        
        return intValue
    }
    
    public func timeInterval(
        forKey key: String,
        nestedIn dictionaryName: String? = nil
    ) throws -> TimeInterval {
        let targetDictionary = try self.getTargetDictionary(name: dictionaryName)

        if let value = targetDictionary[key] as? TimeInterval {
            return value
        }

        let stringValue = try self.string(forKey: key, nestedIn: dictionaryName)
        let keyPath = self.keyPath(key, nestedIn: dictionaryName)
        
        guard let timeIntervalValue = TimeInterval(stringValue) else {
            throw PlistParserError(
                message: "Unable to parse time interval value from key \(keyPath) in \(self.plistName).plist"
            )
        }
        
        return timeIntervalValue
    }
    
    public func url(
        forKey key: String,
        nestedIn dictionaryName: String? = nil
    ) throws -> URL {
        let stringValue = try self.string(forKey: key, nestedIn: dictionaryName)
        let keyPath = self.keyPath(key, nestedIn: dictionaryName)
        
        guard let url = URL(string: stringValue) else {
            throw PlistParserError(
                message: "Unable to parse url from key \(keyPath) in \(self.plistName).plist"
            )
        }
        
        return url
    }
    
    public func dictionary(
        forKey key: String,
        nestedIn dictionaryName: String? = nil
    ) throws -> [String: Any] {
        
        let targetDictionary = try self.getTargetDictionary(name: dictionaryName)
        let keyPath = self.keyPath(key, nestedIn: dictionaryName)

        guard let dictionary = targetDictionary[key] as? [String : Any] else {
            throw PlistParserError(
                message: "Unable to parse dictionary from key \(keyPath) in \(self.plistName).plist"
            )
        }
        
        return dictionary
    }

    private func getTargetDictionary(
        name: String?
    ) throws -> [String: Any] {
        if let dictionaryName = name {
            guard let content = self.plistContent[dictionaryName] as? [String: Any] else {
                throw PlistParserError(
                    message: "Unable to find dictionary \(dictionaryName) in \(self.plistName).plist"
                )
            }
            
            return content
        }
        
        return self.plistContent
    }
    
    private func keyPath(
        _ key: String,
        nestedIn dictionaryName: String? = nil
    ) -> String {
        guard let dictionaryName = dictionaryName else {
            return key
        }
        
        return "\(dictionaryName).\(key)"
    }
}
