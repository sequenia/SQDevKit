//
//  Limiter.swift
//  SQOperations
//
//  Created by Aleksandr Rudikov on 22.08.2022.
//

import Foundation

@available(iOS 13.0, *)
public actor Limiter {

    public enum Policy {

        case throttle
        case debounce
    }

    private let policy: Policy
    private let duration: TimeInterval
    private var task: Task<Void, Never>?

    public init(
        policy: Policy,
        duration: TimeInterval
    ) {
        self.policy = policy
        self.duration = duration
    }

    nonisolated public func callAsFunction(task: @escaping () async -> Void) {
        Task {
            switch policy {
            case .throttle:
                await throttle(task: task)

            case .debounce:
                await debounce(task: task)
            }
        }
    }

    private func throttle(task: @escaping () async -> Void) {
        guard self.task?.isCancelled ?? true else { return }

        Task {
            await task()
        }

        self.task = Task {
            try? await sleep()
            self.task?.cancel()
            self.task = nil
        }
    }

    private func debounce(task: @escaping () async -> Void) {
        self.task?.cancel()

        self.task = Task {
            do {
                try await sleep()
                guard !Task.isCancelled else { return }

                await task()
            } catch {
                return
            }
        }
    }

    private func sleep() async throws {
        try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
    }
}
