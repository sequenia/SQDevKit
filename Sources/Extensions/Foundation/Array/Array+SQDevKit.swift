//
//  File.swift
//  
//
//  Created by Виталий Баник on 25.03.2021.
//

import Foundation

public extension Array {
    
    /// Getting unique elements from an array (with the ability to pass a unique key in closure)
    ///
    /// - Parameters:
    ///   - map: Closure to get the uniqueness parameter of an element`(Element) -> (T)`.
    /// - Returns: array of unique elements `[Element]`
    func unique<T: Hashable>(map: ((Element) -> (T))) -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
    
    /// Getting dictionary elements from an array (with setting key in closure)
    ///
    /// - Parameters:
    ///   - selectKey: Closure to get key for element`(Element) -> Key)`.
    /// - Returns: dictionary `[Key: Element]`
    func toDictionary<Key: Hashable>(with selectKey: ((Element) -> Key)) -> [Key: Element] {
        var dict = [Key: Element]()
        for value in self {
            dict[selectKey(value)] = value
        }
        return dict
    }
    
}
