//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 12.01.2023.
//

import Foundation

public extension Task where Success == Never, Failure == Never {

    static func sleep(seconds: TimeInterval) async {
        let duration = UInt64(seconds * 1_000_000_000)
        try? await Task.sleep(nanoseconds: duration)
    }
}
