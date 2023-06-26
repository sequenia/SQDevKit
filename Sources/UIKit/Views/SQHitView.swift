//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 08.06.2023.
//

import UIKit

public protocol SQHitViewDelegate: AnyObject {

    func anyViewTapped()
}

public class SQHitView: UIView {

    public weak var delegate: SQHitViewDelegate?

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)

        self.delegate?.anyViewTapped()
        return hitView
    }
}
