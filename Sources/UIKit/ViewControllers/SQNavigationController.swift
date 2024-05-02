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
open class SQNavigationController: UINavigationController, UINavigationControllerDelegate {

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        self.topViewController?.preferredStatusBarStyle ?? .default
    }

    override public var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    override public var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    public func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        self.interactivePopGestureRecognizer?.isEnabled = self.viewControllers.count > 1
    }
}

public extension SQExtensions where Base: UIViewController {

    /// Returns `SQNavigationController` with self as root
    var withNavigationController: UINavigationController {
        SQNavigationController(rootViewController: self.base)
    }
}
