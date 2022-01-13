//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 11.01.2022.
//

import Foundation

public protocol SQConfigurableView: AnyObject {

    func configure()
    func setupLayout()
}
