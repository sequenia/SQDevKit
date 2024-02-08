//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 02.03.2021.
//

import UIKit

// MARK: - Associated keys
private struct SQKeyboardProtocolKeys {

    static var didEndShowKeyboardTimer: UInt8 = 0
}

// MARK: - Keyboard Protocol
public protocol KeyboardProtocol: NSObjectProtocol {

    var didEndShowKeyboardTimer: Timer? { get set }

// MARK: - Register/Unregister keyboard
    func registerForKeyboardEvents()
    func unregisterForKeyboardEvents()

// MARK: - Action
    func handleKeyboard(
        withFrame frame: CGRect,
        animationDuration: TimeInterval,
        animationOptions: UIView.AnimationOptions,
        isShow: Bool
    )

    func didEndShowKeyboard()
}

// MARK: - Keyboard Protocol - Default implementation
public extension KeyboardProtocol {

    internal(set) var didEndShowKeyboardTimer: Timer? {
        get {
            guard let value = objc_getAssociatedObject(self, &SQKeyboardProtocolKeys.didEndShowKeyboardTimer) as? Timer
            else { return nil }

            return value
        }
        set {
            objc_setAssociatedObject(self, &SQKeyboardProtocolKeys.didEndShowKeyboardTimer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

// MARK: - Register/Unregister keyboard
    func registerForKeyboardEvents() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil,
            using: { [weak self] (notification) in
                guard let self = self else { return }

                self.willShowKeyboard()
                self.processKeyboard(
                    withNotification: notification,
                    isShow: true
                )
            }
        )

        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: { [weak self] (notification) in
                guard let self = self else { return }
                
                self.processKeyboard(
                    withNotification: notification,
                    isShow: false
                )
            }
        )
    }

    func unregisterForKeyboardEvents() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

// MARK: - Process keyboard
    private func processKeyboard(
        withNotification notification: Notification,
        isShow: Bool
    ) {
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

        self.handleKeyboard(
            withFrame: keyboardFrame,
            animationDuration: animationDuration,
            animationOptions: animationOptions,
            isShow: isShow
        )
    }

    func didEndShowKeyboard() {}

// MARK: - wait show keyboard
    private func willShowKeyboard() {
        if self.didEndShowKeyboardTimer != nil { return }

        self.didEndShowKeyboardTimer = .scheduledTimer(
            withTimeInterval: 0.1,
            repeats: false
        ) { [weak self] timer in

            self?.didEndShowKeyboard()
            timer.invalidate()

            self?.didEndShowKeyboardTimer = nil
        }
    }
}
