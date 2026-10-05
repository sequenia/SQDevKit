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
        self.font = UIFont(
            name: name,
            size: size
        ) ?? .systemFont(
            ofSize: size,
            weight: .init(postScriptName: name)
        )

        self.letterSpacing = letterSpacing
        self.lineHeight = lineHeight
    }

    public init?(json: JSON) {
        guard let name = json["name"].string,
              let size = json["size"].sq.cgFloat,
              let lineHeight = json["lineHeight"].sq.cgFloat else { return nil }
        
        self.font = UIFont(
            name: name,
            size: size
        ) ?? .systemFont(
            ofSize: size,
            weight: .init(postScriptName: name)
        )

        self.letterSpacing = json["letterSpacing"].sq.cgFloat
        self.lineHeight = lineHeight
    }
}

private extension UIFont.Weight {

    init(
        postScriptName name: String
    ) {
        switch name.split(separator: "-").last.map({ $0.lowercased() }) ?? "" {
        case "bold":
            self = .bold

        case "semibold":
            self = .semibold

        case "medium":
            self = .medium

        case "light":
            self = .light

        case "thin":
            self = .thin
        case "heavy", "black":
            self = .heavy

        default:
            self = .regular
        }
    }
}
