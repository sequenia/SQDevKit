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

    public init(_ content: SQSectionContent) {
        self.content = content
    }
}

// MARK: - Hashable
extension SQSection: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.content.id)
        hasher.combine(self.content.items)
        if let headerHash = self.content.header?.hashValue {
            hasher.combine(headerHash)
        }

        if let footerHash = self.content.footer?.hashValue {
            hasher.combine(footerHash)
        }

        if let badgeHash = self.content.badge?.hashValue {
            hasher.combine(badgeHash)
        }
    }
}

// MARK: - Equatable
extension SQSection: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.content.isEqual(to: rhs.content)
    }
}
