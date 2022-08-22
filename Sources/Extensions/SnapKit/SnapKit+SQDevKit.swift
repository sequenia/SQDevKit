//
//  SnapKit+SQDevKit.swift
//  
//
//  Created by Aleksandr Rudikov on 22.08.2022.
//

import Foundation
import SnapKit

public extension SQExtensions where Base == ConstraintMakerExtendable {

    @discardableResult
    func equalTo(_ other: CGFloat) -> ConstraintMakerEditable {
        return self.equalTo(other as ConstraintRelatableTarget)
    }

    @discardableResult
    func lessThanOrEqualTo(_ other: CGFloat) -> ConstraintMakerEditable {
        return self.lessThanOrEqualTo(other as ConstraintRelatableTarget)
    }

    @discardableResult
    func greaterThanOrEqualTo(_ other: CGFloat) -> ConstraintMakerEditable {
        return greaterThanOrEqualTo(other as ConstraintRelatableTarget)
    }
}

public extension SQExtensions where Base == ConstraintMakerEditable {

    @discardableResult
    func multipliedBy(_ amount: CGFloat) -> ConstraintMakerEditable {
        self.multipliedBy(amount as ConstraintMultiplierTarget)
        return self
    }

    @discardableResult
    func dividedBy(_ amount: CGFloat) -> ConstraintMakerEditable {
        self.dividedBy(amount as ConstraintMultiplierTarget)
        return self
    }

    @discardableResult
    func offset(_ amount: CGFloat) -> ConstraintMakerEditable {
        self.offset(amount as ConstraintOffsetTarget)
        return self
    }

    @discardableResult
    func inset(_ amount: CGFloat) -> ConstraintMakerEditable {
        self.inset(amount as ConstraintInsetTarget)
        return self
    }
}
