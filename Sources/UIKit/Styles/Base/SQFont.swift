//
//  SQFont.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit
import SQExtensions
import SwiftyJSON

public struct SQFont {
    
    public let font: UIFont
    public let letterSpacing: CGFloat?
    public let lineHeight: CGFloat

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

    public init?(json: JSON) {
        guard let name = json["name"].string,
              let size = json["size"].sq.cgFloat,
              let lineHeight = json["lineHeight"].sq.cgFloat else { return nil }

        if let font = UIFont(name: name, size: size) {
            self.font = font
        } else {
            self.font = .systemFont(ofSize: size)
        }
        self.letterSpacing = json["letterSpacing"].sq.cgFloat
        self.lineHeight = lineHeight
    }
}
