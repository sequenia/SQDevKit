//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 28.12.2022.
//
import UIKit

public struct SQPhoneFieldStyle {

    public var countryCodeButtonStyle: SQButtonStyle
    public var phoneInputStyle: SQInputStyle

    public var buttonArrowImage: UIImage?
    
    public var borderWidth: CGFloat
    public var borderColor: UIColor?
    public var cornerRadius: CGFloat

    public init(
        countryCodeButtonStyle: SQButtonStyle = .init(),
        phoneInputStyle: SQInputStyle = .init(),
        buttonArrowImage: UIImage? = nil,
        borderWidth: CGFloat = .zero,
        borderColor: UIColor? = nil,
        cornerRadius: CGFloat = .zero
    ) {
        self.countryCodeButtonStyle = countryCodeButtonStyle
        self.phoneInputStyle = phoneInputStyle
        self.buttonArrowImage = buttonArrowImage
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
}
