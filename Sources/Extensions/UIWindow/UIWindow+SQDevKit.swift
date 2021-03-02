//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 01.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIWindow {

    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    static var topMostViewController: UIViewController? {
        guard var topController = self.keyWindow?.rootViewController else { return nil }

        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController

        }

        return topController
    }

    static var tabBarController: UITabBarController? {
        guard let topMostController = self.topMostViewController else { return nil }

        guard let tabBarController = topMostController as? UITabBarController else {
            return nil
        }

        return tabBarController
    }

    static var currentNavigationController: UINavigationController? {
        guard let topMostController = self.topMostViewController else { return nil }

        if let navController = topMostController as? UINavigationController { return navController }

        guard let tabBarController = topMostController as? UITabBarController else { return nil }

        guard let curController = tabBarController.selectedViewController as? UINavigationController else { return nil }

        return curController
    }

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

    static var safeAreaTop: CGFloat {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return 0.0 }

        if #available(iOS 11.0, *) {
            return window.safeAreaInsets.top
        }

        return 0.0
    }

    static var safeAreaBottom: CGFloat {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return 0.0 }

        if #available(iOS 11.0, *) {
            return window.safeAreaInsets.bottom
        }

        return 0.0
    }

}
