//
//  SQListView.swift
//  SQVUPER
//
//  Created by Semen Kologrivov on 26.08.2022.
//

import UIKit
import SQExtensions
import SQCompositionLists
import SnapKit

@available(iOS 13.0, *)
public protocol ListViewDelegate: AnyObject {

    func didSelectModel(_ model: AnyHashable?)
}

@available(iOS 13.0, *)
open class ListView<T: SQListFactory>: UIView, SQListViewProtocol, UICollectionViewDelegate {

// MARK: - UI
    public lazy var collectionView: UICollectionView! = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )

        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    public var factory: SQListFactory!
    public weak var delegate: ListViewDelegate?

// MARK: - init
    public init(collectionViewLayout: UICollectionViewLayout, delegate: ListViewDelegate? = nil) {
        super.init(frame: .zero)

        self.factory = T(collectionView: self.collectionView)
        self.collectionView.collectionViewLayout = collectionViewLayout
        self.delegate = delegate

        self.setupLayout()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Configure collection
    internal func setupCollectionView(
        handler: (_ collectionView: UICollectionView) -> Void
    ) {
        handler(self.collectionView)
    }

// MARK: - Data source
    open func reloadDataWithSectionsContent(
        _ sectionsContent: [SQSectionContent],
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {

        self.reloadData(
            withSectionsContent: sectionsContent,
            animated: animated,
            completion: completion
        )
    }

// MARK: - UICollectionViewDelegate
    open func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(
            at: indexPath,
            animated: true
        )

        let model = self.sections[safe: indexPath.section]?.content.items[safe: indexPath.row]
        self.delegate?.didSelectModel(model)
    }
}

// MARK: - SQConfigurableView
@available(iOS 13.0, *)
extension ListView: SQConfigurableView {

    public func configure() {}

    public func setupLayout() {
        self.addSubview(self.collectionView)

        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
