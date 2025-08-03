//
//  Style.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit

public protocol StyleBase: AnyObject {

    func build()
}

public protocol StyledComponent: StyleBase {

    associatedtype ElementStyle

    var style: ElementStyle { get }

    func resetStyle()
}

open class SQStyle: NSObject {

    internal weak var component: StyleBase?

    public private(set) var strikethroughStyle: NSUnderlineStyle?
    public private(set) var underlineStyle: NSUnderlineStyle?

    public private(set) var textAlignment: NSTextAlignment?
    public private(set) var lineBreakMode: NSLineBreakMode?

    open var attributes: [NSAttributedString.Key: Any] {
        var attrs = [NSAttributedString.Key: Any]()
        let paragraphStyle = NSMutableParagraphStyle()

        if let lineBreakMode = self.lineBreakMode {
            paragraphStyle.lineBreakMode = lineBreakMode
        }

        if let alignment = self.textAlignment {
            paragraphStyle.alignment = alignment
        }

        attrs[.paragraphStyle] = paragraphStyle

        if let strikethroughStyle = self.strikethroughStyle {
            attrs[.strikethroughStyle] = strikethroughStyle.rawValue
        }

        if let underlineStyle = self.underlineStyle {
            attrs[.underlineStyle] = underlineStyle.rawValue
        }

        return attrs
    }

    override public init() {
        super.init()
    }

    public init(component: StyleBase) {
        super.init()

        self.component = component
    }

    public func build() {
        self.component?.build()
    }

    @discardableResult
    open func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    open func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        self.lineBreakMode = lineBreakMode
        return self
    }

    @discardableResult
    open func strikethroughStyle(_ strikethroughStyle: NSUnderlineStyle) -> Self {
        self.strikethroughStyle = strikethroughStyle
        return self
    }

    @discardableResult
    open func underlineStyle(_ underlineStyle: NSUnderlineStyle) -> Self {
        self.underlineStyle = underlineStyle
        return self
    }

    open func convertStringToAttributed(
        _ string: NSAttributedString
    ) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: string)
        attributedString.addAttributes(
            self.attributes,
            range: NSRange(location: .zero, length: attributedString.length)
        )

        return attributedString
    }
    
    open func requiredWidth(
        forString string: String,
        height: CGFloat
    ) -> CGFloat {
        .zero
    }
    
    open func requiredHeight(
        forString string: String,
        width: CGFloat
    ) -> CGFloat {
        .zero
    }
}
