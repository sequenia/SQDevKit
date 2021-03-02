//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

/**
 Use `SQDevKit` proxy as customization point for constrained protocol extensions.

 General pattern would be:

 // 1. Extend SQDevKit protocol with constrain on Base
 // Read as: SQDevKit Extension where Base is a SomeType
 extension SQDevKit where Base: SomeType {
 // 2. Put any specific reactive extension for SomeType here
 }

 With this approach we can have more specialized methods and properties using
 `Base` and not just specialized on common base type.

 */

public struct SQDevKit<Base> {
    /// Base object to extend.
    public let base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has sq extensions.
public protocol SQDevKitCompatible {
    /// Extended type
    associatedtype SQDevKitBase
    
    /// Sq extensions.
    static var sq: SQDevKit<SQDevKitBase>.Type { get set }

    /// Sq extensions.
    var sq: SQDevKit<SQDevKitBase> { get set }
}

extension SQDevKitCompatible {
    /// Sq extensions.
    public static var sq: SQDevKit<Self>.Type {
        get {
            return SQDevKit<Self>.self
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using Reactive to "mutate" base type
        }
    }

    /// Sq extensions.
    public var sq: SQDevKit<Self> {
        get {
            return SQDevKit(self)
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using Reactive to "mutate" base object
        }
    }
}

import class Foundation.NSObject

/// Extend NSObject with `sq` proxy.
extension NSObject: SQDevKitCompatible { }
