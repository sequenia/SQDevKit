//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 12.01.2022.
//

import UIKit

@available(iOS 14.0, *)
public protocol SQTableLayoutManagerDelegate: AnyObject {

    func configureLayout(into config: inout UICollectionLayoutListConfiguration)
    func content(forSection section: Int) -> SQSectionContent?
}

@available(iOS 14.0, *)
public extension SQTableLayoutManagerDelegate {

    func configureLayout(into config: inout UICollectionLayoutListConfiguration) {
        config.backgroundColor = .clear
        config.showsSeparators = false
    }

    func content(forSection section: Int) -> SQSectionContent? { nil }
}

@available(iOS 14.0, *)
open class SQTableLayoutManager {

    private let appearance: UICollectionLayoutListConfiguration.Appearance
    public weak var delegate: SQTableLayoutManagerDelegate!

    public init(
        appearance: UICollectionLayoutListConfiguration.Appearance = .grouped,
        delegate: SQTableLayoutManagerDelegate
    ) {
        self.appearance = appearance
        self.delegate = delegate
    }

    open func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(
            sectionProvider: { index, environment in
                var config = UICollectionLayoutListConfiguration(appearance: self.appearance)
                self.delegate.configureLayout(into: &config)

                let content = self.delegate.content(forSection: index)
                config.headerMode = content?.header == nil ? .none : .supplementary
                config.footerMode = content?.footer == nil ? .none : .supplementary

                return NSCollectionLayoutSection.list(
                    using: config,
                    layoutEnvironment: environment
                )
            }
        )
    }
}
