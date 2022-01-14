//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 12.01.2022.
//

import Foundation

/// Protocol for describing `SQSection`'s content
public protocol SQSectionContent: Any {

    /// Section identifier
    var id: String { get }

    /// Section header
    var header: AnyHashable? { get }

    /// Items in section
    var items: [AnyHashable] { get }

    /// Section footer
    var footer: AnyHashable? { get }
}

/// Class for display in`UICollectionView`
public struct SQSection {

    /// Content of section
    public let content: SQSectionContent

    public init(_ content: SQSectionContent) {
        self.content = content
    }
}

public extension SQSectionContent {

    var header: AnyHashable? { nil }
    var footer: AnyHashable? { nil }
}

// MARK: - Hashable
extension SQSection: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.content.id)
    }
}

// MARK: - Equatable
extension SQSection: Equatable {

    public static func == (lhs: SQSection, rhs: SQSection) -> Bool {
        lhs.content.id == rhs.content.id
    }
}
