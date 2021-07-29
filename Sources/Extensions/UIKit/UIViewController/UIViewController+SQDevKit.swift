//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit


// MARK: - Initialization
public extension SQExtensions where Base: UIViewController {

    /// Returns UINavigationController with self as root
    var wrappedIntoNavigationController: UINavigationController {
        UINavigationController.init(rootViewController: self.base)
    }

    /// Create view controller from storyboard, named as self
    /// 
    /// - Parameters:
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained view controller and named as that
    /// - Returns:new view controller
    static func create(configureBlock: ((_ result: Base) -> Void)? = nil) -> Base? {
        let storyboard = UIStoryboard(name: Base.sq.identifier,
                                      bundle: Bundle.init(for: Base.self))

        guard let controller = storyboard.instantiateInitialViewController() else { return nil }

        var viewController: UIViewController? = controller
        if let navController = controller as? UINavigationController {
            viewController = navController.viewControllers.first
        }

        guard let newViewController = viewController as? Base else { return nil }

        configureBlock?(newViewController)
        return newViewController
    }

    /// Create view controller from storyboard, named as self, wrapped into UINavigationController
    ///
    /// - Parameters:
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained view controller and named as that
    /// - Returns:new navigation view controller
    static func createWithNavigationController(configureBlock: ((_ result: Base) -> Void)? = nil) -> UINavigationController? {
        guard let viewController = Base.self.sq.create(configureBlock: configureBlock) else { return nil }

        return viewController.sq.wrappedIntoNavigationController
    }
}

// MARK: - Push
public extension SQExtensions where Base: UIViewController {

    /// Push into view controller's navigation controller new view controller
    ///
    /// - Parameters:
    ///   - type: type of pushed view controller
    ///   - animated: animation of push. `Bool` (true by default)
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained pushed view controller and named as that
    func push<T: UIViewController>(_ type: T.Type,
                                   animated: Bool = true,
                                   configureBlock: ((_ result: T) -> Void)? = nil) {
        guard let viewController = T.sq.create() else { return }

        configureBlock?(viewController)
        self.base.navigationController?.pushViewController(viewController, animated: animated)
    }

}

// MARK: - Set root
public extension SQExtensions where Base: UIViewController {

    /// Remove all view controllers from stack of view controller's navigation controller and push new view controller
    ///
    /// - Parameters:
    ///   - type: type of pushed view controller
    ///   - animated: animation of push. `Bool`(true by default)
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained pushed view controller and named as that
    func setNavigationRoot<T: UIViewController>(_ type: T.Type,
                                                animated: Bool = true,
                                                configureBlock: ((_ result: T) -> Void)? = nil) {
        guard let viewController = T.sq.create() else { return }

        configureBlock?(viewController)
        self.base.navigationController?.setViewControllers([viewController], animated: animated)
    }
}

// MARK: - Present
public extension SQExtensions where Base: UIViewController {

    /// Present new view controller
    ///
    /// - Parameters:
    ///   - type: type of presented view controller
    ///   - withNavigationController: will be presented view controller wrapped into navigation controller. `Bool` (`true` by default)
    ///   - modalPresentationStyle: style of presentation. `UIModalPresentationStyle` (.pageSheet by default)
    ///   - animated: animation of present]. `Bool` (true by default)
    ///   - configureBlock: closure for configure pushed view controller
    ///   - presentationCompletion: closure when presentation is completed
    /// - Precondition: In your project must exist storyboard contained presented view controller and named as that
    func present<T: UIViewController>(_ type: T.Type,
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
