//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 09.01.2023.
//

import UIKit
import SnapKit
import SQExtensions

public protocol SQCodeInputFieldDelegate: AnyObject {

    func onCodeChanged(_ text: String?)
}

public class SQCodeInputField: UITextField, StyledComponent {

    public typealias ElementStyle = SQCodeInputFieldStyle

    public private(set) lazy var style = ElementStyle(component: self)

    public weak var codeInputDelegate: SQCodeInputFieldDelegate?

    public var numberOfDigits: Int = 4 {
        didSet {
            self.redraw()
        }
    }

    public var spacing: CGFloat = 8 {
        didSet {
            self.redraw()
        }
    }

    public var hasError = false {
        didSet {
            self.redraw()
        }
    }

    public var codePlaceholder: String? = .dotSymbol {
        didSet {
            self.redraw()
        }
    }

    public var digitSize: CGSize = .init(width: 48, height: 48) {
        didSet {
            self.fieldHeightConstraint?.update(offset: self.digitSize.height)
            self.redraw()
            self.setNeedsDisplay()
        }
    }

    override open var text: String? {
        didSet {
            self.redraw()
        }
    }

    public var editable: Bool = true {
        didSet {
            self.redraw()
        }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = false
        stackView.spacing = self.spacing
        return stackView
    }()

    private var labels: [SQCodeInputFieldLabel] {
        self.stackView.arrangedSubviews.compactMap({ $0 as? SQCodeInputFieldLabel })
    }

    private var textInsets: UIEdgeInsets {
        guard let label = self.labels.first else { return .zero }

        return .init(
            horizontal: (self.digitSize.width - label.contentSize.width) / 2,
            vertical: .zero
        )
    }

    private var fieldHeightConstraint: Constraint?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        self.configure()
        self.setupLayout()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.configure()
        self.setupLayout()
    }

    open func build() {
        self.redraw()
    }

    open func resetStyle() {
        self.style = ElementStyle(component: self)
    }

    public func redraw() {
        self.stackView.spacing = self.spacing
        self.stackView.sq.removeAllArrangedSubviews()

        for _ in .zero ..< self.numberOfDigits {
            let label = SQCodeInputFieldLabel()
            label.textColor = self.style.textColor
            label.backgroundColor = self.style.backgroundColor
            label.emptyTextColor = self.style.emptyTextColor
            label.errorTextColor = self.style.errorTextColor
            label.font = self.style.font
            label.isUserInteractionEnabled = false
            label.borderColor = self.style.borderColor
            label.borderErrorColor = self.style.borderErrorColor
            label.cornerRadius = self.style.cornerRadius
            label.borderWidth = self.style.borderWidth
            label.placeholder = self.codePlaceholder
            label.hasError = self.hasError
            label.snp.makeConstraints {
                $0.width.equalTo(self.digitSize.width)
                $0.height.equalTo(self.digitSize.height)
            }
            self.stackView.addArrangedSubview(label)
        }
        if let label = self.labels.first {
            let letterSpacing = CGFloat(self.numberOfDigits - 1) * (CGFloat(self.spacing) + (self.digitSize.width - label.contentSize.width) / 2)
            self.defaultTextAttributes = [
                .kern: letterSpacing,
                .foregroundColor: UIColor.clear
            ]

            if let font = self.style.font {
                self.defaultTextAttributes[.font] = font
            }
        }
        self.updateLabels()
    }

    override open func caretRect(for position: UITextPosition) -> CGRect {
        .zero
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.textInsets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.textInsets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.textInsets)
    }

    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.textInsets))
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        self.labels.forEach { label in
            label.snp.remakeConstraints {
                $0.height.width.equalTo(self.bounds.height)
            }
        }
    }

    @objc
    private func textChanged() {
        self.updateLabels()

        if self.isFirstResponder {
            self.updateFocus()
        }
        
        self.codeInputDelegate?.onCodeChanged(self.text)
    }

    private func updateLabels() {
        guard let text = self.text,
              text.count <= self.numberOfDigits else { return }

        self.labels.enumerated().forEach { index, label in
            if index < text.count {
                let index = text.index(text.startIndex, offsetBy: index)
                let char = self.isSecureTextEntry ? .dotSymbol : String(text[index])
                label.text = char
                label.updateState()
            }
        }
    }

    private func updateFocus() {
        let focusIndex = self.text?.count ?? .zero
        self.labels.enumerated().forEach { index, label in
            label.active = index == focusIndex
        }
    }

    private func removeFocus() {
        let focusIndex = self.text?.count ?? .zero
        guard focusIndex < self.numberOfDigits else {
            return
        }
        self.labels[focusIndex].active = false
    }
}

extension SQCodeInputField: SQConfigurableView {

    public func configure() {
        self.textColor = .clear
        self.keyboardType = .numberPad
        self.borderStyle = .none

        if #available(iOS 12.0, *) {
            self.textContentType = .oneTimeCode
        }

        self.delegate = self
        self.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    public func setupLayout() {
        self.addSubview(stackView)

        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            self.fieldHeightConstraint = $0.height.equalTo(self.digitSize.height).constraint
        }
    }
}

extension SQCodeInputField: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateFocus()
    }

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if !self.editable {
            return false
        }

        guard var text = self.text else {
            return false
        }

        if string.isEmpty, !text.isEmpty {
            text.removeLast()
            self.text = text
            self.textChanged()
            self.updateFocus()
            return false
        }

        if self.hasError && text.count == self.numberOfDigits {
            self.text = string
            self.textChanged()
            self.updateFocus()
            return false
        }

        return text.count < self.numberOfDigits
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.removeFocus()
    }
}

private extension String {

    static let dotSymbol = "●"
}
