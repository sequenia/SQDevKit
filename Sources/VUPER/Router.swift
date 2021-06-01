//
//  VUPERRouter.swift
//
//  Created by Semen Kologrivov on 28.02.2021.
//  Copyright © 2021 Sequenia OOO. All rights reserved.
//

import UIKit
import SQExtensions

// MARK: - VUPER Router
public protocol Router: AnyObject {

// MARK: - Variables
    var topMostViewController: UIViewController? { get }
    var topMostTabViewController: UITabBarController? { get }
    var topMostNavigationController: UINavigationController? { get }
    var currentView: UIViewController? { get }

// MARK: - Navigation actions
    func setRootController(_ controller: UIViewController,
                           animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

// MARK: - VUPER Router - Default implementation
public extension Router {

// MARK: - Variables
    var topMostViewController: UIViewController? {
        UIWindow.sq.topMostViewController
    }

    var topMostTabViewController: UITabBarController? {
        UIWindow.sq.tabBarController
    }

    var topMostNavigationController: UINavigationController? {
        UIWindow.sq.currentNavigationController
    }

    var currentView: UIViewController? {
        UIWindow.sq.currentViewController
    }

// MARK: - Navigation actions
    func setRootController(_ controller: UIViewController, animated: Bool) {
        guard let window = UIWindow.sq.keyWindow else { return }

        if animated {
            window.setRootViewController(controller,
                                         options: UIWindow.TransitionOptions(direction: .fade))
        } else {
            window.rootViewController = controller
        }
    }

    func pop(animated: Bool) {
        self.topMostNavigationController?.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool) {
        self.topMostNavigationController?.popToRootViewController(animated: animated)
    }

    func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.topMostViewController?.dismiss(animated: animated, completion: completion)
    }
}
