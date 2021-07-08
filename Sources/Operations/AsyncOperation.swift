//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 08.07.2021.
//

import Foundation

/// Class for wrapping async tasks (f.e. Moya's request) into operation for the possibility to queue
public class AsyncOperation: Operation {

    public enum State: String {
        case ready     = "ready"
        case executing = "executing"
        case finished  = "finished"

        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }

    public var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }

    private var actions: ((AsyncOperation) -> Void)?

    override public var isReady: Bool {
        return super.isReady && state == .ready
    }

    override public var isExecuting: Bool {
        return state == .executing
    }

    override public var isFinished: Bool {
        return state == .finished
    }

    override public var isAsynchronous: Bool {
        return true
    }

    /// Init for class
    ///
    /// - Parameters:
    ///   - name: name of operation (nil by default)
    ///   - actions: actions for execution in the operation
    public init(
        name: String? = nil,
        actions: @escaping ((AsyncOperation) -> Void)
    ) {
        self.actions = actions

        super.init()

        self.name = name
    }

    override public func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }

    override public func main() {
        self.actions?(self)
    }

    override public func cancel() {
        state = .finished
    }
}
