//
//  CustomizableLayoutAttributes.swift
//  
//
//  Created by Semen Kologrivov on 24.08.2022.
//

import UIKit

#if canImport(SQExtensions)
import SQExtensions
import SQEntities
#endif

// MARK: - CustomizableLayoutAttributes
@available(iOS 13.0, *)
open class CustomizableLayoutAttributes: UICollectionViewLayoutAttributes {

    var settings: UISettings?

    override open func copy(with zone: NSZone? = nil) -> Any {
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
