//
//  Spacings.swift
//  SQUIKit
//
//  Created by Nikolay Komissarov on 22.08.2022.
//

import SwiftyJSON
import SQExtensions
import UIKit

// MARK: - Spacings
public final class Spacings {
    
// MARK: - Properties
    public var top: CGFloat = .zero
    public var bottom: CGFloat = .zero
    
// MARK: - Inits
    public init(
        top: CGFloat = .zero,
        bottom: CGFloat = .zero
    ) {
        self.top = top
        self.bottom = bottom
    }
    
    public init?(withJSON json: JSON) {
        self.top = json["top"].sq.cgFloat ?? .zero
        self.bottom = json["bottom"].sq.cgFloat ?? .zero
    }
}

// MARK: - Equatable
extension Spacings: Equatable {

    public static func == (
        lhs: Spacings,
        rhs: Spacings
    ) -> Bool {
        lhs.top == rhs.top
            && lhs.bottom == rhs.bottom
    }
}

// MARK: - `default`
public extension Spacings {

    static var `default`: Spacings {
        return Spacings()
    }
}
