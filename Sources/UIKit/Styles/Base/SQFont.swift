//
//  SQFont.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit

public struct SQFont {
    
    let font: UIFont
    let letterSpacing: CGFloat?
    let lineHeight: CGFloat

    public init(
        name: String,
        size: CGFloat,
        letterSpacing: CGFloat? = nil,
        lineHeight: CGFloat
    ) {
        if let font = UIFont(name: name, size: size) {
            self.font = font
        } else {
            self.font = .systemFont(ofSize: size)
        }
        self.letterSpacing = letterSpacing
        self.lineHeight = lineHeight
    }

    public init(
        font: UIFont,
        letterSpacing: CGFloat? = nil,
        lineHeight: CGFloat
    ) {

        self.font = font
        self.letterSpacing = letterSpacing
        self.lineHeight = lineHeight
    }
}
