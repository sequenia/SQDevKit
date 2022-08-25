//
//  File.swift
//
//
//  Created by Semen Kologrivov on 12.01.2022.
//

import UIKit

@available(iOS 14.0, *)
public protocol SQTableLayoutManagerDelegate: AnyObject {

    func configureLayout(into config: inout UICollectionViewCompositionalLayoutConfiguration)

    func configureSectionLayout(
        into config: inout UICollectionLayoutListConfiguration,
        for section: SQSectionContent?
    )

    func content(forSection section: Int) -> SQSectionContent?

    func leadingSwipeActionConfiguration(atIndexPath indexPath: IndexPath) -> UISwipeActionsConfiguration?
    func trailingSwipeActionConfiguration(atIndexPath indexPath: IndexPath) -> UISwipeActionsConfiguration?
}

@available(iOS 14.0, *)
public extension SQTableLayoutManagerDelegate {

    func configureLayout(into config: inout UICollectionViewCompositionalLayoutConfiguration) { }

    func configureSectionLayout(
        into config: inout UICollectionLayoutListConfiguration,
        for section: SQSectionContent?
    ) {
        config.backgroundColor = .clear
        config.showsSeparators = false
    }

    func content(forSection section: Int) -> SQSectionContent? { nil }

    func leadingSwipeActionConfiguration(atIndexPath indexPath: IndexPath) -> UISwipeActionsConfiguration? { nil }
    func trailingSwipeActionConfiguration(atIndexPath indexPath: IndexPath) -> UISwipeActionsConfiguration? { nil }
}

@available(iOS 14.0, *)
open class SQTableLayoutManager {

    private let appearance: UICollectionLayoutListConfiguration.Appearance
    public weak var delegate: SQTableLayoutManagerDelegate!

    public init(
        appearance: UICollectionLayoutListConfiguration.Appearance = .plain,
        delegate: SQTableLayoutManagerDelegate
    ) {
        self.appearance = appearance
        self.delegate = delegate
    }

    open func createLayout() -> UICollectionViewLayout {
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider: { index, environment in
                var config = UICollectionLayoutListConfiguration(appearance: self.appearance)
                
                config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                    self?.delegate.trailingSwipeActionConfiguration(atIndexPath: indexPath)
                }
                
                config.leadingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                    self?.delegate.leadingSwipeActionConfiguration(atIndexPath: indexPath)
                }
                

                let content = self.delegate.content(forSection: index)
                config.headerMode = content?.header == nil ? .none : .supplementary
                config.footerMode = content?.footer == nil ? .none : .supplementary

                self.delegate.configureSectionLayout(into: &config, for: content)

                return NSCollectionLayoutSection.list(
                    using: config,
                    layoutEnvironment: environment
                )
            }
        )

        var config = UICollectionViewCompositionalLayoutConfiguration()
        self.delegate.configureLayout(into: &config)
        collectionViewLayout.configuration = config

        return collectionViewLayout
    }
}
