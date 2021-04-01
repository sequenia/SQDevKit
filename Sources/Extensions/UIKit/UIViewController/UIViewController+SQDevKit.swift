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
    static func createWithNavigationController() -> UINavigationController? {
        guard let viewController = Base.self.sq.create() else { return nil }

        return viewController.sq.wrappedIntoNavigationController
    }
}

// MARK: - Push
public extension SQExtensions where Base: UIViewController {

    /// Push into view controller's navigation controller new view controller
    ///
    /// - Parameters:
    ///   - type: type of pushed view controller
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained pushed view controller and named as that
    func push<T: UIViewController>(_ type: T.Type,
                                   configureBlock: ((_ result: T) -> Void)? = nil) {
        self.push(type, animated: true, configureBlock: configureBlock)
    }

    /// Push into view controller's navigation controller new view controller
    ///
    /// - Parameters:
    ///   - type: type of pushed view controller
    ///   - animated: animation of push. `Bool`
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained pushed view controller and named as that
    func push<T: UIViewController>(_ type: T.Type,
                                   animated: Bool,
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
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained pushed view controller and named as that
    func setNavigationRoot<T: UIViewController>(_ type: T.Type,
                                                configureBlock: ((_ result: T) -> Void)? = nil) {
        self.push(type, animated: true, configureBlock: configureBlock)
    }

    /// Remove all view controllers from stack of view controller's navigation controller and push new view controller
    ///
    /// - Parameters:
    ///   - type: type of pushed view controller
    ///   - animated: animation of push. `Bool`
    ///   - configureBlock: closure for configure pushed view controller
    /// - Precondition: In your project must exist storyboard contained pushed view controller and named as that
    func setNavigationRoot<T: UIViewController>(_ type: T.Type,
                                                animated: Bool,
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
    ///   - configureBlock: closure for configure pushed view controller
    ///   - presentationCompletion: closure when presentation is completed
    /// - Precondition: In your project must exist storyboard contained presented view controller and named as that
    func present<T: UIViewController>(_ type: T.Type,
                                      configureBlock: ((_ result: T) -> Void)? = nil) {
        self.present(type,
                     withNavigationController: true,
                     modalPresentationStyle: .pageSheet,
                     animated: true,
                     configureBlock: configureBlock,
                     presentationCompletion: nil)
    }

    /// Present new view controller
    ///
    /// - Parameters:
    ///   - type: type of presented view controller
    ///   - configureBlock: closure for configure pushed view controller
    ///   - presentationCompletion: closure when presentation is completed
    /// - Precondition: In your project must exist storyboard contained presented view controller and named as that
    func present<T: UIViewController>(_ type: T.Type,
                                      configureBlock: ((_ result: T) -> Void)? = nil,
                                      presentationCompletion: ((_ presentedController: UIViewController) -> Void)? = nil) {
        self.present(type,
                     withNavigationController: true,
                     modalPresentationStyle: .pageSheet,
                     animated: true,
                     configureBlock: configureBlock,
                     presentationCompletion: presentationCompletion)
    }

    /// Present new view controller
    ///
    /// - Parameters:
    ///   - type: type of presented view controller
    ///   - modalPresentationStyle: style of presentation. `UIModalPresentationStyle`
    ///   - configureBlock: closure for configure pushed view controller
    ///   - presentationCompletion: closure when presentation is completed
    /// - Precondition: In your project must exist storyboard contained presented view controller and named as that
    func present<T: UIViewController>(_ type: T.Type,
                                      modalPresentationStyle: UIModalPresentationStyle,
                                      configureBlock: ((_ result: T) -> Void)? = nil,
                                      presentationCompletion: ((_ presentedController: UIViewController) -> Void)? = nil) {
        self.present(type,
                     withNavigationController: true,
                     modalPresentationStyle: modalPresentationStyle,
                     animated: true,
                     configureBlock: configureBlock,
                     presentationCompletion: presentationCompletion)
    }

    /// Present new view controller
    ///
    /// - Parameters:
    ///   - type: type of presented view controller
    ///   - withNavigationController: will be presented view controller wrapped into navigation controller. `Bool` (`true` by default)
    ///   - configureBlock: closure for configure pushed view controller
    ///   - presentationCompletion: closure when presentation is completed
    /// - Precondition: In your project must exist storyboard contained presented view controller and named as that
    func present<T: UIViewController>(_ type: T.Type,
                                      withNavigationController: Bool,
                                      configureBlock: ((_ result: T) -> Void)? = nil,
                                      presentationCompletion: ((_ presentedController: UIViewController) -> Void)? = nil) {
        self.present(type,
                     withNavigationController: withNavigationController,
                     modalPresentationStyle: .pageSheet,
                     animated: true,
                     configureBlock: configureBlock,
                     presentationCompletion: presentationCompletion)
    }

    /// Present new view controller
    ///
    /// - Parameters:
    ///   - type: type of presented view controller
    ///   - animated: animation of present. `Bool`
    ///   - configureBlock: closure for configure pushed view controller
    ///   - presentationCompletion: closure when presentation is completed
    /// - Precondition: In your project must exist storyboard contained presented view controller and named as that
    func present<T: UIViewController>(_ type: T.Type,
                                      animated: Bool,
                                      configureBlock: ((_ result: T) -> Void)? = nil,
                                      presentationCompletion: ((_ presentedController: UIViewController) -> Void)? = nil) {
        self.present(type,
                     withNavigationController: true,
                     modalPresentationStyle: .pageSheet,
                     animated: animated,
                     configureBlock: configureBlock,
                     presentationCompletion: presentationCompletion)
    }

    /// Present new view controller
    ///
    /// - Parameters:
    ///   - type: type of presented view controller
    ///   - withNavigationController: will be presented view controller wrapped into navigation controller. `Bool` (`true` by default)
    ///   - modalPresentationStyle: style of presentation. `UIModalPresentationStyle`
    ///   - animated: animation of present]. `Bool`
    ///   - configureBlock: closure for configure pushed view controller
    ///   - presentationCompletion: closure when presentation is completed
    /// - Precondition: In your project must exist storyboard contained presented view controller and named as that
    func present<T: UIViewController>(_ type: T.Type,
                                      withNavigationController: Bool,
                                      modalPresentationStyle: UIModalPresentationStyle,
                                      animated: Bool,
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
