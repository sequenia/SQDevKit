//
//  CustomizableLayout.swift
//  SQUIKit
//
//  Created by Nikolay Komissarov on 22.08.2022.
//

import UIKit

#if canImport(SQExtensions)
import SQExtensions
import SQEntities
#endif

// MARK: - CustomizableLayoutDelegate
public protocol CustomizableLayoutDelegate: AnyObject {
    
    func uiSettings(for indexPath: IndexPath) -> UISettings?
}

// MARK: - CustomizableLayout
@available(iOS 13.0, *)
open class CustomizableLayout: UICollectionViewCompositionalLayout {

// MARK: - Properties
    override open class var layoutAttributesClass: AnyClass {
        return CustomizableLayoutAttributes.self
    }
    
    public weak var delegate: CustomizableLayoutDelegate?

// MARK: - Inits
    override public init(sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider) {
        super.init(sectionProvider: sectionProvider)

        self.configure()
    }

    override public init(
        sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider,
        configuration: UICollectionViewCompositionalLayoutConfiguration
    ) {
        super.init(
            sectionProvider: sectionProvider,
            configuration: configuration
        )

        self.configure()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.configure()
    }

// MARK: - Methods
    private func configure() {
        self.register(
            SectionBackgroundView.self,
            forDecorationViewOfKind: .backgroundElementKind
        )

        self.collectionView?.clipsToBounds = true
    }

// MARK: - Overrides
    override open func layoutAttributesForDecorationView(
        ofKind elementKind: String,
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        let superAttributes = super.layoutAttributesForDecorationView(
            ofKind: elementKind,
            at: indexPath
        )
        
        if elementKind == .backgroundElementKind,
           let attributes = superAttributes as? CustomizableLayoutAttributes,
           let settings = self.delegate?.uiSettings(for: indexPath) {
            attributes.settings = settings
        }

        return superAttributes
    }

    override open func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        let superAttributes = super.layoutAttributesForElements(in: rect)

        superAttributes?.forEach { attribute in
            guard let settings = self.delegate?.uiSettings(for: attribute.indexPath),
                  let customAttribute = attribute as? CustomizableLayoutAttributes
            else { return }
            
            customAttribute.settings = settings
        }
        return superAttributes
    }
}
