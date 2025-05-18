//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 12.01.2022.
//

import Foundation

/// Class for display in`UICollectionView`
public struct SQSection {

    /// Content of section
    public let content: SQSectionContent

    /// Section identifier
    public var id: String {
        self.content.id
    }

    public init(_ content: SQSectionContent) {
        self.content = content
    }
}

// MARK: - Hashable
extension SQSection: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

// MARK: - Equatable
extension SQSection: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.content.isEqualTo(rhs.content)
    }
}
