//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQExtensions where Base: UIApplication {

    /// Application's version number (f.e., 1.0.0)
    static var versionName: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// Application's build number (f.e., 1)
    static var buildName: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }

}
