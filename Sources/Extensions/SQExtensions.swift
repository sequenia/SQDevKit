//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

/**
 Use `SQExtensions` proxy as customization point for constrained protocol extensions.

 General pattern would be:

 1. Extend SQExtensions protocol with constrain on Base
   Read as: SQExtensions Extension where Base is a SomeType
   extension SQExtensions where Base: SomeType  {

    2. Put any specific reactive extension for SomeType here
   }

 With this approach we can have more specialized methods and properties using
 `Base` and not just specialized on common base type.

 */

public struct SQExtensions<Base> {
    /// Base object to extend.
    public var base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has sq extensions.
public protocol SQExtensionsCompatible {

    /// Extended type
    associatedtype SQExtensionsBase
    
    /// Sq extensions.
    static var sq: SQExtensions<SQExtensionsBase>.Type { get set }

    /// Sq extensions.
    var sq: SQExtensions<SQExtensionsBase> { get set }
}

extension SQExtensionsCompatible {

    /// Sq extensions.
    public static var sq: SQExtensions<Self>.Type {
        get {
            return SQExtensions<Self>.self
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using Reactive to "mutate" base type
        }
    }

    /// Sq extensions.
    public var sq: SQExtensions<Self> {
        get {
            return SQExtensions(self)
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using Reactive to "mutate" base object
        }
    }
}

import class Foundation.NSObject

/// Extend NSObject with `sq` proxy.
extension NSObject: SQExtensionsCompatible { }

import SwiftyJSON
/// Extend JSON with `sq` proxy.
extension JSON: SQExtensionsCompatible { }

import SnapKit

extension ConstraintMakerExtendable: SQExtensionsCompatible {}

extension ConstraintMakerEditable: SQExtensionsCompatible {}

extension Constraint: SQExtensionsCompatible {}
