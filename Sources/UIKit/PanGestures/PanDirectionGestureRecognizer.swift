//
//  File.swift
//  
//
//  Created by Семен Кологривов on 22.12.2023.
//

import UIKit

public class PanDirectionGestureRecognizer: UIPanGestureRecognizer {
    
    public enum PanDirection {
        case vertical
        case horizontal
    }

    let direction: PanDirection

    public init(direction: PanDirection, target: AnyObject, action: Selector) {
        self.direction = direction
        super.init(target: target, action: action)
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        if self.state == .began {
            let vel = velocity(in: self.view)
            switch direction {
            case .horizontal where abs(vel.y) > abs(vel.x):
                self.state = .cancelled

            case .vertical where abs(vel.x) > abs(vel.y):
                self.state = .cancelled

            default:
                break
            }
        }
    }
}
