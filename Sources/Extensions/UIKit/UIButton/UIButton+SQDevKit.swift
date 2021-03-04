//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIButton {

    ///  Set background color for button with specific state
    ///
    /// - Parameters:
    ///   - color: color for background. `UIColor`
    ///   - state: state of button. `UIControl.State`
    func setBackgroundColor(_ color: UIColor?,
                            forState state: UIControl.State) {
        self.base.setBackgroundImage(UIImage.sq.create(withColor: color),
                                     for: state)
    }
}
