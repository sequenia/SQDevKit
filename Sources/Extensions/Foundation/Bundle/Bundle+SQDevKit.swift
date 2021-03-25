//
//  File.swift
//  
//
//  Created by Виталий Баник on 25.03.2021.
//

import Foundation

public extension SQDevKit where Base:  Bundle {
    
    /// Release version number as string
    var releaseVersionNumber: String? {
        return self.base.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// build version number as string
    var buildVersionNumber: String? {
        return self.base.infoDictionary?["CFBundleVersion"] as? String
    }
}
