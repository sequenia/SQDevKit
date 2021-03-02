//
//  BasicConfigurator.swift
//  TwoPoTwo
//
//  Created by Semen Kologrivov on 01.03.2021.
//  Copyright © 2021 Sequenia OOO. All rights reserved.
//

import Foundation

// MARK: - VUPER Configurator
public protocol VUPERConfigurator where Self: NSObject {

// MARK: - Types
    associatedtype View: VUPERView
    associatedtype Presenter: VUPERPresenter

// MARK: - VUPER
    var view: View? { get }
    var presenter: Presenter? { get }

// MARK: - Configuration
    func configure()
}
