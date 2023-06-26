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

    static func getAllMethods() -> [String] {
        let myClass = Base.self

        var methodCount: UInt32 = 0
        guard let methodList = class_copyMethodList(myClass, &methodCount) else { return [] }

        var methods = [String]()
        for index in 0..<Int(methodCount) {
            let selName = sel_getName(method_getName(methodList[index]))
            if let methodName = String(cString: selName, encoding: .utf8) {
                methods.append(methodName)
            }
        }
        return methods
    }
}
