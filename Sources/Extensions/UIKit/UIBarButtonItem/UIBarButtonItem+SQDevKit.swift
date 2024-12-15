//
//  File.swift
//  SQDevKit
//
//  Created by Семен Кологривов on 15.12.2024.
//

import UIKit
import SnapKit

public extension UIBarButtonItem {
    
    convenience init(
        customView: UIView,
        navigationBar: UINavigationBar
    ) {
        if let button = customView as? UIButton,
           let buttonImage = button.image(for: .normal) {
            button.snp.makeConstraints {
                $0.height.width.equalTo(navigationBar.frame.height)
            }

            if #available(iOS 15.0, *) {
                var buttonConfiguration = UIButton.Configuration.plain()
                buttonConfiguration.contentInsets = .init(
                    top: .zero,
                    leading: (navigationBar.frame.height - buttonImage.size.width),
                    bottom: .zero,
                    trailing: .zero
                )
                button.configuration = buttonConfiguration
            }
        }
        
        self.init(customView: customView)
    }
}

