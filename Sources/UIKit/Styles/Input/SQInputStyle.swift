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
    public private(set) var clearButtonImage: UIImage?

    private var textColors = [UIControl.State: UIColor]()
    private var backgroundColors = [UIControl.State: UIColor]()
    private var borderColors = [UIControl.State: UIColor]()
    private var borderWidths = [UIControl.State: CGFloat]()
    private var cornerRadiuses = [UIControl.State: CGFloat]()

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
    open func clearButtonImage(_ image: UIImage?) -> Self {
        self.clearButtonImage = image
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
    open func backgroundColor(_ color: UIColor?, forState state: UIControl.State = .normal) -> Self {
        if let backgroundColor = color {
            self.backgroundColors[state] = backgroundColor
        }
        return self
    }

    open func backgroundColor(forState state: UIControl.State = .normal) -> UIColor? {
        self.backgroundColors[state] ?? self.backgroundColors[.normal]
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
    open func borderWidth(_ width: CGFloat, forState state: UIControl.State = .normal) -> Self {
        self.borderWidths[state] = width
        return self
    }

    open func borderWidth(forState state: UIControl.State = .normal) -> CGFloat {
        (self.borderWidths[state] ?? self.borderWidths[.normal]) ?? .zero
    }

    @discardableResult
    open func cornerRadius(_ radius: CGFloat, forState state: UIControl.State = .normal) -> Self {
        self.cornerRadiuses[state] = radius
        return self
    }

    open func cornerRadius(forState state: UIControl.State = .normal) -> CGFloat {
        (self.cornerRadiuses[state] ?? self.cornerRadiuses[.normal]) ?? .zero
    }
}
