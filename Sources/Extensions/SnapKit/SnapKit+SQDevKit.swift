//
//  SnapKit+SQDevKit.swift
//  
//
//  Created by Aleksandr Rudikov on 22.08.2022.
//

import Foundation
import SnapKit
import UIKit

public extension SQExtensions where Base == ConstraintMakerExtendable {

    @discardableResult
    func equalTo(_ other: CGFloat) -> ConstraintMakerEditable {
        return base.equalTo(other as ConstraintRelatableTarget)
    }

    @discardableResult
    func lessThanOrEqualTo(_ other: CGFloat) -> ConstraintMakerEditable {
        return base.lessThanOrEqualTo(other as ConstraintRelatableTarget)
    }

    @discardableResult
    func greaterThanOrEqualTo(_ other: CGFloat) -> ConstraintMakerEditable {
        return base.greaterThanOrEqualTo(other as ConstraintRelatableTarget)
    }
}

public extension SQExtensions where Base == ConstraintMakerEditable {

    @discardableResult
    func multipliedBy(_ amount: CGFloat) -> ConstraintMakerEditable {
        base.multipliedBy(amount as ConstraintMultiplierTarget)
        return base
    }

    @discardableResult
    func dividedBy(_ amount: CGFloat) -> ConstraintMakerEditable {
        base.dividedBy(amount as ConstraintMultiplierTarget)
        return base
    }

    @discardableResult
    func offset(_ amount: CGFloat) -> ConstraintMakerEditable {
        base.offset(amount as ConstraintOffsetTarget)
        return base
    }

    @discardableResult
    func inset(_ amount: CGFloat) -> ConstraintMakerEditable {
        base.inset(amount as ConstraintInsetTarget)
        return base
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
