//
//  CornersRadiuses.swift
//  SQUIKit
//
//  Created by Nikolay Komissarov on 22.08.2022.
//

import SwiftyJSON
import UIKit
import SQExtensions

// MARK: - CornersRadiuses
public final class CornersRadiuses {
    
// MARK: - Properties
    var topLeft: CGFloat = .zero
    var topRight: CGFloat = .zero
    var bottomLeft: CGFloat = .zero
    var bottomRight: CGFloat = .zero
    
// MARK: - Inits
    public init(
        topLeft: CGFloat = .zero,
        topRight: CGFloat = .zero,
        bottomLeft: CGFloat = .zero,
        bottomRight: CGFloat = .zero
    ) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }

    public init(radius: CGFloat) {
        self.topLeft = radius
        self.topRight = radius
        self.bottomLeft = radius
        self.bottomRight = radius
    }

    public init?(withJSON json: JSON) {
        self.topLeft = json["top_left"].sq.cgFloat ?? .zero
        self.topRight = json["top_right"].sq.cgFloat ?? .zero
        self.bottomLeft = json["bottom_left"].sq.cgFloat ?? .zero
        self.bottomRight = json["bottom_right"].sq.cgFloat ?? .zero
    }
}

// MARK: - Equatable
extension CornersRadiuses: Equatable {

    public static func == (
        lhs: CornersRadiuses,
        rhs: CornersRadiuses
    ) -> Bool {
        lhs.topLeft == rhs.topLeft
            && lhs.topRight == rhs.topRight
            && lhs.bottomLeft == rhs.bottomLeft
            && lhs.bottomRight == rhs.bottomRight
    }
}

// MARK: - `default`
public extension CornersRadiuses {

    static var `default`: CornersRadiuses {
        return CornersRadiuses()
    }
}
