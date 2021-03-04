//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 04.03.2021.
//

import UIKit

public extension SQDevKit where Base: UIButton {

    func setBacgroundColor(_ color: UIColor?,
                           forState state: UIControl.State) {
        self.base.setBackgroundImage(UIImage.sq.create(withColor: color),
                                     for: state)
    }
}
