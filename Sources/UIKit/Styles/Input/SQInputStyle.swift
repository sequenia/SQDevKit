//
//  SQInputStyle.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit

open class SQInputStyle: SQTextStyle {

    public private(set) var cursorColor: UIColor?
    public private(set) var textInsets: UIEdgeInsets = .zero

    private var textColors = [UIControl.State: UIColor]()
    private var borderColors = [UIControl.State: UIColor]()
    private var borderWidths = [UIControl.State: CGFloat]()

    @discardableResult
    open func cursorColor(_ color: UIColor?) -> Self {
        self.cursorColor = color
        return self
    }

    @discardableResult
    open func textInsets(_ insets: UIEdgeInsets) -> Self {
        self.textInsets = insets
        return self
    }

    @discardableResult
    open func textColor(_ color: UIColor?, forState state: UIControl.State = .normal) -> Self {
        if let textColor = color {
            self.textColors[state] = textColor
        }
        return self
    }

    open func textColor(forState state: UIControl.State = .normal) -> UIColor? {
        self.textColors[state] ?? self.textColors[.normal]
    }

    @discardableResult
    open func borderColor(_ color: UIColor?, forState state: UIControl.State = .normal) -> Self {
        if let borderColor = color {
            self.borderColors[state] = borderColor
        }
        return self
    }

    open func borderColor(forState state: UIControl.State = .normal) -> UIColor? {
        self.borderColors[state] ?? self.borderColors[.normal]
    }

    @discardableResult
    func borderWidth(_ width: CGFloat, forState state: UIControl.State = .normal) -> Self {
        self.borderWidths[state] = width
        return self
    }

    open func borerWidth(forState state: UIControl.State = .normal) -> CGFloat {
        (self.borderWidths[state] ?? self.borderWidths[.normal]) ?? .zero
    }
}
