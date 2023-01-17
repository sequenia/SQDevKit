//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 10.01.2023.
//

import UIKit
import SnapKit

class SQCodeInputFieldLabel: UIView {

    var placeholder: String? {
        didSet {
            self.redraw()
        }
    }

    var text: String? {
        didSet {
            self.redraw()
        }
    }

    var font: UIFont? = .systemFont(ofSize: 14) {
        didSet {
            self.redraw()
        }
    }

    var active = false {
        didSet {
            guard oldValue != self.active else { return }

            if self.active == true {
                self.startAnimation()
            } else {
                self.stopAnimation()
            }
        }
    }

    var hasError = false {
        didSet {
            guard oldValue != self.hasError else { return }

            self.redraw()
        }
    }

    var borderColor: UIColor? = .clear {
        didSet {
            self.redraw()
        }
    }

    var borderErrorColor: UIColor? = .red {
        didSet {
            self.redraw()
        }
    }

    var cornerRadius: CGFloat = 0 {
        didSet {
            self.redraw()
        }
    }

    var borderWidth: CGFloat = 0 {
        didSet {
            self.redraw()
        }
    }

    var textColor: UIColor? = .black {
        didSet {
            self.redraw()
        }
    }

    var emptyTextColor: UIColor? = .clear {
        didSet {
            self.redraw()
        }
    }

    var errorTextColor: UIColor? = .red {
        didSet {
            self.redraw()
        }
    }

    var contentSize: CGSize {
        self.label.bounds.size
    }

    private var animator = UIViewPropertyAnimator()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private var hasText: Bool {
        return self.text?.isEmpty == false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.configure()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateState() {
        self.stopAnimation()
    }

    private func redraw() {
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.cornerRadius

        if self.hasError {
            self.layer.borderColor = self.borderErrorColor?.cgColor ?? self.borderErrorColor?.cgColor
            self.label.textColor = self.hasText ? self.errorTextColor : self.emptyTextColor
        } else {
            self.layer.borderColor = self.borderColor?.cgColor
            self.label.textColor = self.hasText ? self.textColor : self.emptyTextColor
        }
        self.label.text = self.hasText ? self.text : self.placeholder
    }

    private func startAnimation() {
        self.animator = UIViewPropertyAnimator(
            duration: 0.5,
            dampingRatio: 0.9,
            animations: {
                self.redraw()
            }
        )
        self.animator.startAnimation()
    }

    private func stopAnimation() {
        self.animator.addAnimations {
            self.redraw()
        }
        self.animator.startAnimation()
    }
}

extension SQCodeInputFieldLabel: SQConfigurableView {

    public func configure() {
        self.clipsToBounds = false
    }

    public func setupLayout() {
        self.addSubview(self.label)
        self.label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
