//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 11.01.2022.
//

import UIKit

#if canImport(SQExtensions)
import SQExtensions
#endif

/// Inheritance of UINavigationController for easy work with screen-specified status bar style
open class SQNavigationController: UINavigationController {

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        self.topViewController?.preferredStatusBarStyle ?? .default
    }

    override public var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    override public var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}

public extension SQExtensions where Base: UIViewController {

    /// Returns `SQNavigationController` with self as root
    var withNavigationController: UINavigationController {
        SQNavigationController(rootViewController: self.base)
    }
}
