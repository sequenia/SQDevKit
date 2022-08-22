//
//  CustomizableLayout.swift
//  SQUIKit
//
//  Created by Nikolay Komissarov on 22.08.2022.
//

import UIKit
import SQCompositionLists

// MARK: - CustomizableLayoutAttributes
public class CustomizableLayoutAttributes: UICollectionViewLayoutAttributes {

    var settings: UISettings?
    
    override open func copy(with zone: NSZone? = nil) -> Any {
        // swiftlint:disable force_cast
        let copy = super.copy(with: zone) as! CustomizableLayoutAttributes
        copy.settings = self.settings
        return copy
    }

    override open func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CustomizableLayoutAttributes {
            return super.isEqual(object) &&
            attributes.settings == self.settings
        } else {
            return false
        }
    }
}

// MARK: - CustomizableLayoutDelegate
public protocol CustomizableLayoutDelegate: AnyObject {
    
    func uiSettings(for indexPath: IndexPath) -> UISettings?
}

// MARK: - CustomizableLayout
@available(iOS 13.0, *)
open class CustomizableLayout: UICollectionViewCompositionalLayout {

// MARK: - Properties
    open override class var layoutAttributesClass: AnyClass {
        return CustomizableLayoutAttributes.self
    }
    
    public weak var delegate: CustomizableLayoutDelegate?

// MARK: - Inits
    public override init(sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider) {
        super.init(sectionProvider: sectionProvider)

        self.configure()
    }

    public override init(
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
    open override func layoutAttributesForDecorationView(
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

    open override func layoutAttributesForElements(
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
