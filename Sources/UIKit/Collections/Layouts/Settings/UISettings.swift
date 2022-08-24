//
//  SQUISettings.swift
//  SQUIKit
//
//  Created by Nikolay Komissarov on 22.08.2022.
//

import SwiftyJSON
import SQCompositionLists
import UIKit

// MARK: - UISettings
public final class UISettings {
   
// MARK: - Properties
    public var backgroundColor: UIColor? = .clear
    public var spacings: Spacings = .default
    public var cornersRadiuses: CornersRadiuses = .default
    
// MARK: - Inits
    public init(
        backgroundColor: UIColor = .clear,
        spacing: Spacings = .default,
        cornerRadiuses: CornersRadiuses = .default
    ) {
        self.backgroundColor = backgroundColor
        self.spacings = spacing
        self.cornersRadiuses = cornerRadiuses
    }
    
    public init?(withJSON json: JSON) {
        self.backgroundColor = UIColor(withRGBA: json["background_color"].string ?? "") ?? .clear
        self.spacings = Spacings(withJSON: json["spacings"]) ?? .default
        self.cornersRadiuses = CornersRadiuses(withJSON: json["corners_radiuses"]) ?? .default
    }
}

// MARK: - Equatable
extension UISettings: Equatable {

    public static func == (
        lhs: UISettings,
        rhs: UISettings
    ) -> Bool {
        lhs.backgroundColor == rhs.backgroundColor
            && lhs.spacings == rhs.spacings
            && lhs.cornersRadiuses == rhs.cornersRadiuses
    }
}

// MARK: - `default`
public extension UISettings {

    static var `default`: UISettings {
        return UISettings()
    }
}
