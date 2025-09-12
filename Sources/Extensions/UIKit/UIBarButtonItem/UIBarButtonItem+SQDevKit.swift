//
//  File.swift
//  SQDevKit
//
//  Created by Семен Кологривов on 15.12.2024.
//

import UIKit
import SnapKit

public enum SQBarSide {
    case left
    case right
}


public extension UIBarButtonItem {
    
    convenience init(
        customView: UIView,
        navigationBar: UINavigationBar,
        atSide side: SQBarSide
    ) {
        if let button = customView as? UIButton {
            button.snp.makeConstraints {
                $0.height.equalTo(navigationBar.frame.height)
                $0.width.greaterThanOrEqualTo(navigationBar.frame.height)
            }

            if let buttonImage = button.image(for: .normal) {
                if #available(iOS 15.0, *) {
                    var buttonConfiguration = button.configuration ?? UIButton.Configuration.plain()
                    buttonConfiguration.contentInsets = .init(
                        top: .zero,
                        leading: (navigationBar.frame.height - buttonImage.size.width),
                        bottom: .zero,
                        trailing: .zero
                    )
                    button.configuration = buttonConfiguration
                }
            }
        }
        
        self.init(customView: customView)
    }
}

