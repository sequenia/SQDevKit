//
//  SnapKit+SQDevKit.swift
//  
//
//  Created by Aleksandr Rudikov on 22.08.2022.
//

import Foundation
import SnapKit
import UIKit

public extension Float {

    static let layoutLowPriority: Float = 250
    static let layoutDefaultPriority: Float = 750
    static let layoutHighPriority: Float = 1000
}

public extension SQExtensions where Base == ConstraintMakerExtendable {

    @discardableResult
    func equalTo(_ other: CGFloat) -> ConstraintMakerEditable {
        base.equalTo(other as ConstraintRelatableTarget)
    }

    @discardableResult
    func lessThanOrEqualTo(_ other: CGFloat) -> ConstraintMakerEditable {
        base.lessThanOrEqualTo(other as ConstraintRelatableTarget)
    }

    @discardableResult
    func greaterThanOrEqualTo(_ other: CGFloat) -> ConstraintMakerEditable {
        base.greaterThanOrEqualTo(other as ConstraintRelatableTarget)
    }
}

public extension SQExtensions where Base == ConstraintMakerEditable {

    @discardableResult
    func multipliedBy(_ amount: CGFloat) -> ConstraintMakerEditable {
        base.multipliedBy(amount as ConstraintMultiplierTarget)
    }

    @discardableResult
    func dividedBy(_ amount: CGFloat) -> ConstraintMakerEditable {
        base.dividedBy(amount as ConstraintMultiplierTarget)
    }

    @discardableResult
    func offset(_ amount: CGFloat) -> ConstraintMakerEditable {
        base.offset(amount as ConstraintOffsetTarget)
    }

    @discardableResult
    func inset(_ amount: CGFloat) -> ConstraintMakerEditable {
        base.inset(amount as ConstraintInsetTarget)
    }
}

public extension SQExtensions where Base == ConstraintViewDSL {

    func makeLabelConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        base.makeConstraints { make in
            base.contentHuggingHorizontalPriority = 240
            base.contentCompressionResistanceHorizontalPriority = 240
            closure(make)
        }
    }

}

public extension SQExtensions where Base == Constraint {

    @discardableResult
    func update(offset: CGFloat) -> Constraint {
        base.update(offset: offset as ConstraintOffsetTarget)
    }

    @discardableResult
    func update(inset: CGFloat) -> Constraint {
        base.update(inset: inset as ConstraintInsetTarget)
    }
}
