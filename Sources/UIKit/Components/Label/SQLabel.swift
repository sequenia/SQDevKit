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
        let constraintBox = CGSize(
            width: labelWidth,
            height: .greatestFiniteMagnitude
        )

        return self.attirubtedStringForCalculation(originalString: attributedString)
            .boundingRect(
                with: constraintBox,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            .height
            .rounded(.up)
    }
    
    open func requiredWidth(withHeight height: CGFloat) -> CGFloat {
        guard let attributedString = self.attributedText else { return .zero }
        
        if attributedString.string.isEmpty { return .zero }

        let labelHeight = self.frame.height <= .zero ? height : self.frame.height
        let constraintBox = CGSize(
            width: .greatestFiniteMagnitude,
            height: labelHeight
        )
        
        return self.attirubtedStringForCalculation(originalString: attributedString)
            .boundingRect(
                with: constraintBox,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            .width
            .rounded(.up)
    }
    
    private func attirubtedStringForCalculation(originalString: NSAttributedString) -> NSAttributedString {
        var newAttributedString = NSMutableAttributedString(string: originalString.string)
        originalString.attributes(at: .zero, effectiveRange: nil).forEach { attribute in
            if attribute.key == .paragraphStyle,
               let originalParagraphStyle = attribute.value as? NSParagraphStyle {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.setParagraphStyle(originalParagraphStyle)
                paragraphStyle.lineBreakMode = .byWordWrapping

                newAttributedString.addAttribute(attribute.key, value: paragraphStyle, range: NSRange(location: .zero, length: originalString.length))

                return
            }

            newAttributedString.addAttribute(attribute.key, value: attribute.value, range: NSRange(location: .zero, length: originalString.length))
        }
        
        return newAttributedString
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
