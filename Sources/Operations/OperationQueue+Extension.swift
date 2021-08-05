//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 08.07.2021.
//

import Foundation
import SQExtensions

public extension SQExtensions where Base: OperationQueue {

    /// Execute block after all operations from the array.
    func onFinish(_ block: @escaping () -> Void) {
        let doneOperation = BlockOperation(block: block)
        self.base.operations.forEach { [unowned doneOperation] in doneOperation.addDependency($0) }
        self.base.addOperation(doneOperation)
    }
}
