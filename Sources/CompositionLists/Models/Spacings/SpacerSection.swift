//
//  SpacerSection.swift
//  WetNose
//
//  Created by Semen Kologrivov on 02.06.2022.
//  Copyright © 2022 Sequenia. All rights reserved.
//

import UIKit

public struct SpacerSection: SQSectionContent {

    public var id: String
    public var parentSectionId: String

    public var items: [AnyHashable]

    public init(
        id: String,
        parentSectionId: String,
        height: CGFloat,
        backgroundColor: UIColor = .clear
    ) {
        self.id = [id, "EmptyCell"].joined(separator: "_")
        self.parentSectionId = parentSectionId
        self.items = [
            EmptyModel(
                id: id,
                height: height,
                backgroundColor: backgroundColor
            )
        ]
    }
}
