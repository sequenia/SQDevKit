//
//  BasicViewController.swift
//  TwoPoTwo
//
//  Created by Semen Kologrivov on 26.02.2021.
//  Copyright © 2021 Sequenia OOO. All rights reserved.
//

import UIKit

// MARK: - VUPER View
public protocol VUPERView where Self: UIViewController {
    
// MARK: - Loading indicator
    func setLoadingVisible(_ visible: Bool)

// MARK: - Error message
    func showErrorMessage(_ message: String?)
    func showErrorMessage(_ message: String?,
                          retryBlock: @escaping () -> Void)
}
