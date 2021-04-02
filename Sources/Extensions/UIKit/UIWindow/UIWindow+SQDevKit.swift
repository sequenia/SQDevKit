//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension SQExtensions where Base: UIWindow {

    /// Application's key window
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    /// Current top most presented view controller
    static var topMostViewController: UIViewController? {
        guard var topController = self.keyWindow?.rootViewController else { return nil }

        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController

        }

        return topController
    }

    /// Current top most presented tab bar controller
    static var tabBarController: UITabBarController? {
        guard let topMostController = self.topMostViewController else { return nil }

        guard let tabBarController = topMostController as? UITabBarController else {
            return nil
        }

        return tabBarController
    }

    /// Current top most presented navigation controller
    static var currentNavigationController: UINavigationController? {
        guard let topMostController = self.topMostViewController else { return nil }

        if let navController = topMostController as? UINavigationController { return navController }

        guard let tabBarController = topMostController as? UITabBarController else { return nil }

        guard let curController = tabBarController.selectedViewController as? UINavigationController else { return nil }

        return curController
    }

    /// Current view controller
    /// If top most presenter view controller is UINavigationController, value will be equal last view controller in navigation stack
    /// If top most presenter view controller is UITabController, value will be equal view controller in selected tab
    static var currentViewController: UIViewController? {
        guard let currentViewController = self.topMostViewController else { return nil }

        if let tabController = currentViewController as? UITabBarController {
            let selectedViewController = tabController.selectedViewController
            if let navController = selectedViewController as? UINavigationController {
                return navController.viewControllers.last
            }

            return selectedViewController
        } else if let navController = currentViewController as? UINavigationController {
            return navController.viewControllers.last
        }

        return currentViewController
    }

    /// Top safe area inset of key window
    static var safeAreaTop: CGFloat {
        guard let window = self.keyWindow else { return 0.0 }

        if #available(iOS 11.0, *) {
            return window.safeAreaInsets.top
        }

        return 0.0
    }

    /// Bottom safe area inset of key window
    static var safeAreaBottom: CGFloat {
        guard let window = self.keyWindow else { return 0.0 }

        if #available(iOS 11.0, *) {
            return window.safeAreaInsets.bottom
        }

        return 0.0
    }

}
