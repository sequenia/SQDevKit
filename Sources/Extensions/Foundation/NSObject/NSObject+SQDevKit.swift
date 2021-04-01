//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import Foundation

public extension SQExtensions where Base: NSObject {

    /// String identifier of object
    static var identifier: String {
        return String(describing: Base.self)
    }
}


