//
//  BasicPresenter.swift
//  TwoPoTwo
//
//  Created by Semen Kologrivov on 26.02.2021.
//  Copyright © 2021 Sequenia OOO. All rights reserved.
//

import Foundation

// MARK: - VUPER Presenter
public protocol VUPERPresenter: class {

// MARK: - Types
    associatedtype View: VUPERView
    associatedtype Router: VUPERRouter

// MARK: - VUPER
    var view: View? { get }
    var router: Router? { get }

// MARK: - Life Cycle
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewDidUnload()
    func didReceiveMemoryWarning()

// MARK: - Close
    func close(animated: Bool)
    func close(animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
}

// MARK: - VUPER Presenter - Default implementation
public extension VUPERPresenter {

// MARK: - Life Cycle
    func viewWillAppear() {

    }

    func viewDidAppear() {

    }

    func viewWillDisappear() {

    }

    func viewDidDisappear() {

    }

    func viewDidUnload(){

    }

    func didReceiveMemoryWarning() {

    }

// MARK: - Close
    func close(animated: Bool) {
        self.close(animated: animated, completion: nil)
    }

    func close(animated: Bool, completion: (() -> Void)?) {
        self.router?.dismiss(animated: animated, completion: completion)
    }

    func pop(animated: Bool) {
        self.router?.pop(animated: animated)
    }
}
