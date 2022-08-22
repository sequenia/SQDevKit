//
//  SpacerModel.swift
//  WetNose
//
//  Created by Nikolay on 27/05/2022.
//  Copyright 2022 Sequenia. All rights reserved.
//

import UIKit

public struct EmptyModel {

    let id: String
    let height: CGFloat?
    let backgroundColor: UIColor
    
    public init(
        id: String,
        height: CGFloat?,
        backgroundColor: UIColor = .clear
    ) {
        self.id = id
        self.height = height
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Hashable
extension EmptyModel: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

// MARK: - Equatable
extension EmptyModel: Equatable {

    public static func == (lhs: EmptyModel, rhs: EmptyModel) -> Bool {
        lhs.id == rhs.id
            && lhs.height == rhs.height
    }
}
