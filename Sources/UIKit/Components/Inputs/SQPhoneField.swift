//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 28.12.2022.
//

import UIKit
import SnapKit
import AnyFormatKit
import SQExtensions

public protocol SQPhone: Any {

    var countryCode: String { get }
    var number: String { get set }
    var mask: String { get }
}

public extension SQPhone {

    var numberOfDigits: Int {
        self.mask.reduce(.zero) { partialResult, character in
            character == "#" ? partialResult + 1 : partialResult
        }
    }
}

public protocol SQPhoneFieldDelegate: AnyObject {

    func onClickCountryButton()
    func onChangePhoneNumber(_ phoneNumber: SQPhone?, isAutofilled: Bool)
}

public class SQPhoneField: UIView {

    public weak var delegate: SQPhoneFieldDelegate?

    public var style = SQPhoneFieldStyle() {
        didSet {
            self.onChangeStyle()
        }
    }

    public private(set) var phoneNumber: SQPhone?

    public var isEnabled: Bool = true {
        didSet {
            self.countryButton.isEnabled = self.isEnabled
        }
    }

    private var phoneInputFormatter: DefaultTextInputFormatter!

    private lazy var countryButton: SQButton = {
        let button = SQButton()
        button.addAction(
            .init(
                handler: { [weak self] _ in
                    guard let self = self else { return }

                    self.onClickCountryButton()
                }
            ),
            for: .touchUpInside
        )
        button.semanticContentAttribute = .forceRightToLeft

        let spacing: CGFloat = 4
        button.imageEdgeInsets = .init(
            top: .zero,
            left: spacing,
            bottom: .zero,
            right: .zero
        )
        button.titleEdgeInsets = .init(
            top: .zero,
            left: spacing,
            bottom: .zero,
            right: spacing
        )
        return button
    }()

    private lazy var separator = UIView()

    private lazy var textField: SQTextField = {
        let field = SQTextField()
        field.delegate = self
        field.autocorrectionType = .yes
        field.rightViewMode = .whileEditing
        field.keyboardType = .numberPad
        field.textContentType = .telephoneNumber
        return field
    }()

    private var separatorWidth: Constraint?

    override public var canBecomeFirstResponder: Bool {
        return true
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        self.configure()
        self.setupLayout()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func beginEditing() {
        _ = self.textField.becomeFirstResponder()
    }

    public func setPhoneNumber(_ phoneNumber: SQPhone?) {
        self.phoneNumber = phoneNumber

        self.onSetPhoneNumber()
    }

    private func onChangeStyle() {
        self.sq.setCornerRadius(self.style.cornerRadius)

        self.sq.setBorderWidth(self.style.borderWidth)
        self.separatorWidth?.update(offset: self.style.borderWidth)

        self.separator.backgroundColor = self.style.borderColor
        self.sq.setBorderColor(self.style.borderColor)

        self.countryButton.setImage(
            self.style.buttonArrowImage,
            for: .normal
        )

        self.countryButton
            .style(self.style.countryCodeButtonStyle)
            .build()

        self.textField
            .style(self.style.phoneInputStyle)
            .build()

        self.setNeedsLayout()
    }

    private func onSetPhoneNumber() {
        guard let phoneNumber = self.phoneNumber else { return }

        self.countryButton.setTitle(
            phoneNumber.countryCode,
            for: .normal
        )

        self.phoneInputFormatter = DefaultTextInputFormatter(
            textPattern: phoneNumber.mask
        )

        self.textField.text = self.phoneInputFormatter.format(phoneNumber.number)
    }

    private func onClickCountryButton() {
        self.delegate?.onClickCountryButton()
    }

//    public var numberOfDigits: Int {
//        self.country.phoneNumberInputMask.reduce(.zero) { partialResult, character in
//            character == "#" ? partialResult + 1 : partialResult
//        }
//    }
}

extension SQPhoneField: UITextFieldDelegate {

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if !self.isEnabled {
            return false
        }

        let isAutofill = range == NSRange(location: .zero, length: .zero) && string.count > 1
        var replacementString = string.sq.digits
        if isAutofill {
            let digitsCount = self.phoneNumber?.numberOfDigits ?? .zero
            replacementString = String(string.sq.digits.suffix(digitsCount))
        }

        let result = self.phoneInputFormatter.formatInput(
            currentText: textField.text ?? "",
            range: range,
            replacementString: replacementString
        )

        let formattedPhone = result.formattedText
        let unformattedPhone = self.phoneInputFormatter.unformat(formattedPhone) ?? ""

        textField.text = formattedPhone
        textField.setCursorLocation(result.caretBeginOffset)

        if self.phoneNumber?.number != unformattedPhone {
            self.phoneNumber?.number = unformattedPhone
            self.delegate?.onChangePhoneNumber(
                self.phoneNumber,
                isAutofilled: isAutofill
            )
        }

        return false
    }
}

extension SQPhoneField: SQConfigurableView {

    public func configure() {
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.textField.autocorrectionType = .no
        self.textField.textContentType = .telephoneNumber
    }

    public func setupLayout() {
        self.addSubview(self.countryButton)
        self.addSubview(self.textField)
        self.addSubview(self.separator)

        self.countryButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.medium)
            $0.height.sq.equalTo(.fieldHeight)
            $0.width.sq.greaterThanOrEqualTo(55)
        }

        self.textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(self.countryButton.snp.trailing)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.sq.equalTo(.fieldHeight)
        }

        self.separator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.medium)
            $0.leading.equalTo(self.countryButton.snp.trailing)
            self.separatorWidth = $0.width.equalTo(1).constraint
        }

        self.countryButton.snp.contentHuggingHorizontalPriority = .layoutHighPriority
    }

}

private extension CGFloat {

    static let fieldHeight: CGFloat = 46
}

private extension UITextField {

    func setCursorLocation(_ location: Int) {
        guard let cursorLocation = self.position(from: self.beginningOfDocument, offset: location) else { return }

        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.selectedTextRange = strongSelf.textRange(from: cursorLocation, to: cursorLocation)
        }
    }

}
