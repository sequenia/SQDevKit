//
//  BasicViewController.swift
//  TwoPoTwo
//
//  Created by Semen Kologrivov on 26.02.2021.
//  Copyright © 2021 Sequenia OOO. All rights reserved.
//

import UIKit

// MARK: - VUPER View
public protocol VUPERView where Self: UIViewController {

// MARK: - Types
    associatedtype Presenter: VUPERPresenter
    associatedtype Configurator: VUPERConfigurator

// MARK: - VUPER
    var presenter: Presenter? { get }
    var configurator: Configurator? { get }

// MARK: - Loading indicator
    func setLoadingVisible(_ visible: Bool)

// MARK: - Error message
    func showErrorMessage(_ message: String?)
    func showErrorMessage(_ message: String?,
                          retryBlock: @escaping () -> Void)
}

// MARK: - Basic View Controller
/* open class BasicViewController<Presenter: BasicPresenter, Configurator: BasicConfigurator>: UIViewController, BasicView, UIAdaptivePresentationControllerDelegate {

// MARK: - VUPER
    public var presenter: Presenter?
    public var configurator: Configurator?

// MARK: - Properties
    internal private(set) var keyboardIsShown = false
    internal private(set) var keyboardHeight: CGFloat = .zero
    
// MARK: - Life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.viewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.registerForKeyboard()
        self.presenter?.viewWillAppear()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.presenter?.viewDidAppear()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.unregisterForKeyboard()
        self.presenter?.viewWillDisappear()
    }

// MARK: - Basic View - Loading indicator
    open func setLoadingVisible(_ visible: Bool) {
    }


// MARK: - Basic View - Error message
    open func showErrorMessage(_ message: String?) {
    }

    open func showErrorMessageAndRetry(_ message: String?,
                                           retryBlock: @escaping () -> Void) {
    }

    open func showErrorMessage(_ message: String?,
                                 title: String?,
                                 leftButtonTitle: String? = nil,
                                 leftButtonHandler: (() -> Void)? = nil,
                                 rightButtonTitle: String? = nil,
                                 rightButtonHandler: (() -> Void)? = nil) {
    }

// MARK: - Keyboard
    @objc
    internal func keyboardWillShow(_ notification: NSNotification) {
        self.keyboardIsShown = true

        self.processKeyboardNotification(notification)
    }

    @objc
    internal func keyboardWillHide(_ notification: NSNotification) {
        self.keyboardIsShown = false

        self.processKeyboardNotification(notification)
    }

    open func handleKeyboard(withFrame frame: CGRect,
                             animationDuration: TimeInterval,
                             animationOptions: UIView.AnimationOptions,
                             shown: Bool) {

    }

}

// MARK: - Keyboard
extension BasicViewController {

    private func registerForKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func unregisterForKeyboard() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)

        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    private func processKeyboardNotification(_ notification: NSNotification) {

        var keyboardFrame: CGRect = .zero
        var animationDuration: TimeInterval = 0.2
        var animationOptions: UIView.AnimationOptions = .curveLinear

        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardFrame = frame.cgRectValue
        }

        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            animationDuration = duration
        }

        if let rawOptions = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int {
            animationOptions = UIView.AnimationOptions(rawValue: UInt(rawOptions << 16))
        }

        self.keyboardHeight = keyboardFrame.height
        self.handleKeyboard(withFrame: keyboardFrame,
                            animationDuration: animationDuration,
                            animationOptions: animationOptions,
                            shown: self.keyboardIsShown)
    }
}

 */
