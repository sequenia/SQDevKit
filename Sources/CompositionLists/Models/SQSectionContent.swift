//
//  SQSectionContent.swift
//  SQCompositionLists
//
//  Created by Semen Kologrivov on 18.07.2022.
//

import Foundation

/// Protocol for describing `SQSection`'s content
public protocol SQSectionContent: Any {

    /// Section identifier
    var id: String { get }

    /// Section header
    var header: AnyHashable? { get }

    /// Section badge
    var badge: AnyHashable? { get }

    /// Items in section
    var items: [AnyHashable] { get }

    /// Section footer
    var footer: AnyHashable? { get }
}

public extension SQSectionContent {

    var header: AnyHashable? { nil }

    var badge: AnyHashable? { nil }

    var items: [AnyHashable] {
        []
    }

    var footer: AnyHashable? { nil }
}
