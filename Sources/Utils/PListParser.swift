//
//  File.swift
//  
//
//  Created by Семен Кологривов on 23.08.2024.
//

import Foundation

public class PListParser {
    
    private var plistName: String
    private var plistContent: [String: Any]
    
    public init(plistName: String = "Info") {
        guard let plistPath = Bundle.main.path(forResource: plistName, ofType: "plist"),
              let content = NSDictionary(contentsOfFile: plistPath) as? [String: Any] else {
            fatalError("Unable to find \(plistName).plist in resources")
        }

        self.plistName = plistName
        self.plistContent = content
    }
    
    public func string(forKey key: String, nestedIn dictionaryName: String? = nil) -> String {
        let targetDictionary = self.getTargetDictionary(name: dictionaryName)
        
        guard let value = targetDictionary[key] as? String else {
            let keyPath = self.keyPath(key, nestedIn: dictionaryName)
            fatalError("Unable to find key \(keyPath) in \(self.plistName).plist")
        }
        
        return value
    }
    
    public func bool(forKey key: String, nestedIn dictionaryName: String? = nil) -> Bool {
        let stringValue = self.string(forKey: key, nestedIn: dictionaryName).lowercased()
        
        return stringValue == "true" || stringValue == "yes" || stringValue == "1"
    }
    
    public func int(forKey key: String, nestedIn dictionaryName: String? = nil) -> Int {
        let stringValue = self.string(forKey: key, nestedIn: dictionaryName)
        let keyPath = self.keyPath(key, nestedIn: dictionaryName)
        
        guard let intValue = Int(stringValue) else {
            fatalError("Unable to parse integer value from key \(keyPath) in \(self.plistName).plist")
        }
        
        return intValue
    }
    
    public func timeInterval(forKey key: String, nestedIn dictionaryName: String? = nil) -> TimeInterval {
        let stringValue = self.string(forKey: key, nestedIn: dictionaryName)
        let keyPath = self.keyPath(key, nestedIn: dictionaryName)
        
        guard let timeIntervalValue = TimeInterval(stringValue) else {
            fatalError("Unable to parse time interval value from key \(keyPath) in \(self.plistName).plist")
        }
        
        return timeIntervalValue
    }
    
    public func url(forKey key: String, nestedIn dictionaryName: String? = nil) -> URL {
        let stringValue = self.string(forKey: key, nestedIn: dictionaryName)
        let keyPath = self.keyPath(key, nestedIn: dictionaryName)
        
        guard let url = URL(string: stringValue) else {
            fatalError("Unable to parse url from key \(keyPath) in \(self.plistName).plist")
        }
        
        return url
    }

    private func getTargetDictionary(name: String?) -> [String: Any] {
        if let dictionaryName = name {
            guard let content = self.plistContent[dictionaryName] as? [String: Any] else {
                fatalError("Unable to find dictionary \(dictionaryName) in \(self.plistName).plist")
            }
            
            return content
        }
        
        return self.plistContent
    }
    
    private func keyPath(_ key: String, nestedIn dictionaryName: String? = nil) -> String {
        guard let dictionaryName = dictionaryName else {
            return key
        }
        
        return "\(dictionaryName).\(key)"
    }
}
