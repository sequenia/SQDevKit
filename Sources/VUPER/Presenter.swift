//
//  VUPERPresenter.swift
//
//  Created by Semen Kologrivov on 26.02.2021.
//  Copyright © 2021 Sequenia OOO. All rights reserved.
//

import Foundation

// MARK: - VUPER Presenter
public protocol Presenter: AnyObject {

// MARK: - Life Cycle
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewDidUnload()
    func didReceiveMemoryWarning()
}
