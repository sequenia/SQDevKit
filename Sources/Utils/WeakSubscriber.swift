//
//  File.swift
//  
//
//  Created by Семен Кологривов on 30.11.2023.
//

import Foundation

public protocol Subscribable: AnyObject {

    var subscribableIdentifier: String { get }
}

public class WeakSubscriber {

    public private(set) weak var weakRef: Subscribable?

    public init(_ weakRef: Subscribable) {
        self.weakRef = weakRef
    }
}
