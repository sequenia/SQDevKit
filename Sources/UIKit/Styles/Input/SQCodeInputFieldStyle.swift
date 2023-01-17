//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 10.01.2023.
//

import UIKit

open class SQCodeInputFieldStyle: SQTextStyle {

    public private(set) var emptyTextColor: UIColor?
    public private(set) var errorTextColor: UIColor?

    public private(set) var borderColor: UIColor?
    public private(set) var borderErrorColor: UIColor?

    public private(set) var borderWidth: CGFloat = .zero
    public private(set) var cornerRadius: CGFloat = .zero

    @discardableResult
    open func emptyTextColor(_ color: UIColor?) -> Self {
        self.emptyTextColor = color
        return self
    }

    @discardableResult
    open func errorTextColor(_ color: UIColor?) -> Self {
        self.errorTextColor = color
        return self
    }

    @discardableResult
    open func borderColor(_ color: UIColor?) -> Self {
        self.borderColor = color
        return self
    }

    @discardableResult
    open func borderErrorColor(_ color: UIColor?) -> Self {
        self.borderErrorColor = color
        return self
    }

    @discardableResult
    open func borderWidth(_ width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }

    @discardableResult
    open func cornerRadius(_ radius: CGFloat) -> Self {
        self.cornerRadius = radius
        return self
    }
}
