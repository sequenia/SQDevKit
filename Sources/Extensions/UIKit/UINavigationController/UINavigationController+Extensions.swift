//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 06.08.2021.
//

import UIKit

/// Protocol for styling navigation bar
public protocol NavigationBarStyle {
    /// Navigation's bar background image. Required
    var backgroundImage: UIImage? { get }

    /// Navigation's bar background image. Required
    var tintColor: UIColor? { get }

    /// Navigation's bar back indicator image. Not required, will be used system style without implementation
    var backIndicatorImage: UIImage? { get }

    /// Navigation's bar back indicator transition mask image. Not required, will be used system style without implementation
    var backIndicatorTransitionMaskImage: UIImage? { get }

    /// Navigation's bar hairline color. Not required, will be setted clear color without implementation
    var shadowColor: UIColor? { get }

    /// Navigation's bar back opacity mode. Nnot required, will equal false without implementation
    var isTranslucent: Bool { get }

    /// Navigation's bar title attributes (font, color, etc.) . Not required, will be used system style without implementation
    var titleAttributes: [NSAttributedString.Key: Any] { get }

    /// Navigation's bar blur effect. Not required, will be equal nil without implementation
    var blurEffect: UIBlurEffect? { get }
}

public extension NavigationBarStyle {

    var backIndicatorImage: UIImage? { nil }
    var backIndicatorTransitionMaskImage: UIImage? { nil }

    var shadowColor: UIColor? { .clear }
    var isTranslucent: Bool { false }
    var titleAttributes: [NSAttributedString.Key: Any] { [ : ] }
    var blurEffect: UIBlurEffect? { nil }

    var shadowImage: UIImage? { UIImage.sq.create(withColor: self.shadowColor) }
}

public extension SQExtensions where Base: UINavigationController {

    /// Configure navigation bar by passed style
    ///
    /// - Parameters:
    ///   - style: style for navigation bar. `NavigationBarStyle`.
    func setNavigationBarStyle(_ style: NavigationBarStyle) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.shadowImage = style.shadowImage
            appearance.titleTextAttributes = style.titleAttributes
            appearance.backgroundEffect = nil
            appearance.setBackIndicatorImage(
                style.backIndicatorImage,
                transitionMaskImage: style.backIndicatorTransitionMaskImage
            )
            appearance.backgroundImage = style.backgroundImage
            self.base.navigationBar.standardAppearance = appearance
        } else {
            self.base.navigationBar.shadowImage = style.shadowImage
            self.base.navigationBar.titleTextAttributes = style.titleAttributes
            self.base.navigationBar.backIndicatorImage = style.backIndicatorImage
            self.base.navigationBar.backIndicatorTransitionMaskImage = style.backIndicatorTransitionMaskImage
            self.base.navigationBar.setBackgroundImage(style.backgroundImage, for: .default)
        }
        self.base.navigationBar.tintColor = style.tintColor
        self.base.navigationBar.isTranslucent = style.isTranslucent

        self.setupBlur(forStyle: style)
    }

    private func setupBlur(forStyle style: NavigationBarStyle) {
        self.base.navigationBar.sq.removeBlur()

        guard let blurEffect = style.blurEffect else { return }

        let statusBarHeight = UIDevice.sq.statusBarHeight
        var blurFrame = self.base.navigationBar.bounds
        blurFrame.size.height += statusBarHeight
        blurFrame.origin.y -= statusBarHeight

        self.base.navigationBar.sq.addBlur(blurEffect, color: .clear)
    }

}
