//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 20.09.2022.
//

import UIKit

open class SQLabel: UILabel, StyledComponent {

    public typealias ElementStyle = SQTextStyle

    public private(set) lazy var style = ElementStyle(component: self)

    override open var text: String? {
        didSet {
            self.build()
        }
    }

    open func build() {
        self.updateAttributedText()
    }

    open func resetStyle() {
        self.style = ElementStyle(component: self)
    }
    
    open func requiredHeight(withWidth width: CGFloat) -> CGFloat {
        guard let attributedString = self.attributedText else { return .zero }
        
        if attributedString.string.isEmpty { return .zero }

        let labelWidth = self.frame.width <= .zero ? width : self.frame.width
        
        return self.style.requiredHeight(
            forString: attributedString.string,
            width: labelWidth
        )
    }
    
    open func requiredWidth(withHeight height: CGFloat) -> CGFloat {
        guard let attributedString = self.attributedText else { return .zero }
        
        if attributedString.string.isEmpty { return .zero }

        let labelHeight = self.frame.height <= .zero ? height : self.frame.height
        let constraintBox = CGSize(
            width: .greatestFiniteMagnitude,
            height: labelHeight
        )
        
        return self.style.requiredWidth(
            forString: attributedString.string,
            height: labelHeight
        )
    }

    private func updateAttributedText() {
        let attributedString: NSAttributedString
        if let labelAttributedText = self.attributedText {
            attributedString = labelAttributedText
        } else {
            attributedString = NSAttributedString(string: self.text ?? "")
        }

        self.attributedText = self.style.convertStringToAttributed(
            attributedString
        )
        self.invalidateIntrinsicContentSize()
    }
}
