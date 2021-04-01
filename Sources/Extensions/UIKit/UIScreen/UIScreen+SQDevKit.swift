//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQExtensions where Base: UIScreen {

    /// Screen width
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }

    /// Screen height
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }

}
