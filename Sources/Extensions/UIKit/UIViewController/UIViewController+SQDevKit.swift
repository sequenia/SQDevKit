//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIViewController {

    /// Returns UINavigationController with self as root
    var wrappedIntoNavigationController: UINavigationController {
        UINavigationController.init(rootViewController: self.base)
    }

    /// Create view controller from storyboard, named as self
    ///
    /// - Precondition: In your project must exist storyboard contained view controller and named as that
    /// - Returns:new view controller
    static func create() -> Base? {
        let storyboard = UIStoryboard(name: Base.sq.identifier,
                                      bundle: Bundle.init(for: Base.self))
        let viewController = storyboard.instantiateInitialViewController()
        if let navController = viewController as? UINavigationController {
            return navController.viewControllers.first as? Base
        }

        return viewController as? Base
    }

    /// Create view controller from storyboard, named as self, wrapped into UINavigationController
    ///
    /// - Precondition: In your project must exist storyboard contained view controller and named as that
    /// - Returns:new navigation view controller
    static func createWithNavigationController<T: UIViewController>(_ type: T.Type) -> UINavigationController? {
        guard let viewController = T.self.sq.create() else { return nil }

        return viewController.sq.wrappedIntoNavigationController
    }

    /// Push into view controller's navigation controller new view controller
    ///
    /// - Parameters:
    ///   - type: type of pushed view controller
    ///   - animated: animation of push. `Bool`
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained pushed view controller and named as that
    func push<T: UIViewController>(_ type: T.Type,
                                   animated: Bool = true,
                                   configureBlock: ((_ result: T) -> Void)? = nil) {
        guard let viewController = T.sq.create() else { return }

        configureBlock?(viewController)
        self.base.navigationController?.pushViewController(viewController, animated: animated)
    }

    /// Remove all view controllers from stack of view controller's navigation controller and push new view controller
    ///
    /// - Parameters:
    ///   - type: type of pushed view controller
    ///   - animated: animation of push. `Bool`
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained pushed view controller and named as that
    func setNavigationRoot<T: UIViewController>(_ type: T.Type,
                                                animated: Bool = true,
                                                configureBlock: ((_ result: T) -> Void)? = nil) {
        guard let viewController = T.sq.create() else { return }

        configureBlock?(viewController)
        self.base.navigationController?.setViewControllers([viewController], animated: animated)
    }

    /// Present new view controller
    ///
    /// - Parameters:
    ///   - type: type of presented view controller
    ///   - withNavigationController: will be presented view controller wrapped into navigation controller. `Bool` (`true` by default)
    ///   - modalPresentationStyle: style of presentation. `UIModalPresentationStyle`
    ///   - animated: animation of push. `Bool`
    ///   - configureBlock: closure for configure pushed view controller
    ///   - presentationCompletion: closure when presentation is completed
    /// - Precondition: In your project must exist storyboard contained presented view controller and named as that
    func present<T: UIViewController>(_type: T,
                                      withNavigationController: Bool = true,
                                      modalPresentationStyle: UIModalPresentationStyle = .pageSheet,
                                      animated: Bool = true,
                                      configureBlock: ((_ result: T) -> Void)? = nil,
                                      presentationCompletion: ((_ presentedController: UIViewController) -> Void)? = nil) {
        guard let viewController = T.sq.create() else { return }
        configureBlock?(viewController)

        let viewControllerToPresent = withNavigationController ? viewController.sq.wrappedIntoNavigationController : viewController
        viewControllerToPresent.modalPresentationStyle = modalPresentationStyle

        UIWindow.sq.topMostViewController?.present(viewControllerToPresent,
                                                   animated: animated,
                                                   completion: {
                                                    presentationCompletion?(viewControllerToPresent)
        })
    }
}
