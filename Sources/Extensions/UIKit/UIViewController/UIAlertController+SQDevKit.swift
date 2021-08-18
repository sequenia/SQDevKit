//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 18.08.2021.
//

import UIKit

public extension SQExtensions where Base: UIAlertController {

    func presentInOwnWindow(showOnceOnly: Bool, animated: Bool, completion: (() -> Void)?) {
        let windowAlertPresentationController = WindowAlertPresentationController(alert: self.base)
        windowAlertPresentationController.present(animated: animated, completion: completion)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        if self.base.presentingViewController is WindowAlertPresentationController {
            self.base.presentingViewController?.dismiss(animated: animated, completion: completion)
            return
        }

        self.base.dismiss(animated: animated, completion: completion)
    }
}

private class WindowAlertPresentationController: UIViewController {

// MARK: - Properties
    private lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    private let alert: UIAlertController

// MARK: - Initialization
    init(alert: UIAlertController) {

        self.alert = alert
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This initializer is not supported")
    }

// MARK: - Presentation
    func present(showOnceOnly: Bool = false, animated: Bool, completion: (() -> Void)?) {

        if showOnceOnly {
            var existed = false
            for window in UIApplication.shared.windows {
                if window.rootViewController is WindowAlertPresentationController {
                    existed = true
                    break
                }
            }
            if !existed {
                window?.rootViewController = self
                window?.windowLevel = UIWindow.Level.alert + 1
                window?.makeKeyAndVisible()
                present(alert, animated: animated, completion: completion)
            }
        } else {
            window?.rootViewController = self
            window?.windowLevel = UIWindow.Level.alert + 1
            window?.makeKeyAndVisible()
            present(alert, animated: animated, completion: completion)
        }


    }

// MARK: - Overrides
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) {
            self.window = nil
            completion?()
        }
    }
}

