//
//  VUPERView.swift
//
//  Created by Semen Kologrivov on 26.02.2021.
//  Copyright © 2021 Sequenia OOO. All rights reserved.
//

import UIKit

// MARK: - VUPER View
public protocol View where Self: UIViewController {
    
// MARK: - Loading indicator
    @MainActor
    func setLoadingVisible(_ visible: Bool)

// MARK: - Error message
    @MainActor
    func showErrorMessage(_ message: String?)
    @MainActor
    func showErrorMessage(_ message: String?, retryBlock: @escaping () -> Void)
}
