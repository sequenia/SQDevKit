//
//  SQButton.swift
//  UIComponents
//
//  Created by Semen Kologrivov on 21.09.2022.
//

import UIKit
import SQExtensions
import SnapKit

open class SQButton: UIButton, StyledComponent, SQConfigurableView {

    public typealias ElementStyle = SQButtonStyle

    public lazy var style = ElementStyle(component: self)

    private var _customState: UInt = 0

    private lazy var activityContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.style = .medium
        return loader
    }()

    override open var state: UIControl.State {
       return UIControl.State(rawValue: super.state.rawValue | self._customState)
    }

    open var isLoading: Bool {
        get {
            return self._customState & UIControl.State.loading.rawValue == UIControl.State.loading.rawValue
        } set {
            if newValue == true {
                self._customState |= UIControl.State.loading.rawValue
            } else {
                self._customState &= ~UIControl.State.loading.rawValue
            }

            self.activityContainerView.isHidden = !self.isLoading
            if self.isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }

            self.setupColor()
            self.updateAttributedText()
            self.updateTintColor()
            self.setNeedsDisplay()
        }
    }

    override open var isHighlighted: Bool {
        didSet {
            self.setupColor()
            self.updateAttributedText()
            self.updateTintColor()
            self.setNeedsDisplay()
        }
    }

    override open var isSelected: Bool {
        didSet {
            self.setupColor()
            self.updateAttributedText()
            self.updateTintColor()
            self.setNeedsDisplay()
        }
    }

    override open var isEnabled: Bool {
        didSet {
            self.setupColor()
            self.updateAttributedText()
            self.updateTintColor()
            self.setNeedsDisplay()
        }
    }

    override open var isHidden: Bool {
        didSet {
            self.setupColor()
            self.updateAttributedText()
            self.updateTintColor()
            self.setNeedsDisplay()
        }
    }

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

    override open func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)

        self.updateAttributedText()
    }

    override open func draw(_ rect: CGRect) {
        super.draw(rect)

        self.updateLayer()
    }

    open func configure() {
        self.clipsToBounds = true
        if #available(iOS 15.0, *) {
            self.configurationUpdateHandler = { button in
                let title = button.title(for: button.state)
                let attributes = self.style.attributes(forState: button.state)
                var container = AttributeContainer()
                if button.state == .loading {
                    container.foregroundColor = .clear
                } else {
                    if let color = self.style.textColor(forState: button.state) {
                        container.foregroundColor = color
                    }
                }
                if let font = attributes[.font] as? UIFont {
                    container.font = font
                }
                if let kern = attributes[.kern] as? CGFloat {
                    container.kern = kern
                }
                if let strikethroughStyle = attributes[.strikethroughStyle] as? Int {
                    container.underlineStyle = .init(rawValue: strikethroughStyle)
                }
                if let underlineStyle = attributes[.underlineStyle] as? Int {
                    container.underlineStyle = .init(rawValue: underlineStyle)
                }
                button.configuration?.attributedTitle = AttributedString(
                    title ?? "",
                    attributes: container
                )

                var background = UIBackgroundConfiguration.clear()
                background.backgroundColor = self.style.backgroundColor(forState: button.state) ?? .clear
                button.configuration?.background = background

            }
        }
    }

    open func setupLayout() {
        self.addSubview(self.activityContainerView)
        self.addSubview(self.activityIndicator)

        self.activityContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    open func build() {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .init(
                top: .zero,
                leading: self.style.contentInsets.left,
                bottom: .zero,
                trailing: self.style.contentInsets.right
            )
            self.configuration = configuration
        } else {
            self.setupColor()
            self.updateAttributedText()
            self.contentEdgeInsets = .init(
                top: .zero,
                left: self.style.contentInsets.left,
                bottom: .zero,
                right: self.style.contentInsets.right
            )
        }

        self.updateTintColor()
        self.setNeedsDisplay()
    }

    open func resetStyle() {
        self.style = ElementStyle(component: self)
    }

    open func setupColor() {
        let controlStates: [UIControl.State] = [.normal, .highlighted, .selected, .disabled, .loading]
        controlStates.forEach { state in
            if let textColor = self.style.textColor(forState: state) {
                self.setTitleColor(self.isLoading ? .clear : textColor, for: state)
            }
            if let backgroundColor = self.style.backgroundColor(forState: state) {
                self.setBackgroundImage(.sq.create(withColor: backgroundColor), for: state)
            }
        }
    }

    open func updateTintColor() {
        self.tintColor = self.style.tintColor(forState: self.state)
        self.activityIndicator.color = self.style.tintColor(forState: self.state)
    }

    open func updateLayer() {
        self.layer.borderColor = self.style.borderColor(forState: self.state)?.cgColor
        self.layer.borderWidth = self.style.borderWidth(forState: self.state)
        self.layer.cornerRadius = self.style.cornerRadius(forState: self.state)
    }

    open func updateAttributedText() {
        let attributedString = NSAttributedString(string: self.title(for: self.state) ?? "")

        let convertedString = self.style.convertStringToAttributed(
            attributedString,
            forState: self.state
        )
        self.setAttributedTitle(
            convertedString,
            for: self.state
        )
        self.invalidateIntrinsicContentSize()
    }
}
