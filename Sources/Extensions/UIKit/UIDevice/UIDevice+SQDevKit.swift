//
//  File.swift
//  
//
//  Created by Olga Lidman on 12.05.2021.
//

import Foundation
import UIKit

public extension SQExtensions where Base: UIDevice {

    /// Check if device has narrow screen (like iPhone 5/5c/5s/SE)
    static var isNarrowScreen: Bool {
        return UIScreen.sq.width == 568.0 || UIScreen.sq.width == 320.0
    }
    
    /// Current screen orientation
    static var isLandscape: Bool {
        return UIDevice.current.orientation.isValidInterfaceOrientation ?
            UIDevice.current.orientation.isLandscape : UIApplication.shared.statusBarOrientation.isLandscape
    }

    /// Status bar height
    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

    /// Device model identifier
    static var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }

            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }

    /// Device model name
    static var modelName: String {
        return self.mapToDevice(identifier: self.modelIdentifier)
    }

    private static func mapToDevice(identifier: String) -> String {
        #if os(iOS)
        switch identifier {
// MARK: - iPods
        case "iPod5,1":                                  return "iPod touch (5th generation)"
        case "iPod7,1":                                  return "iPod touch (6th generation)"
        case "iPod9,1":                                  return "iPod touch (7th generation)"
// MARK: - iPhones
        case "iPhone3,1":                                return "iPhone 4"
        case "iPhone3,2":                                return "iPhone 4 GSM Rev A"
        case "iPhone3,3":                                return "iPhone 4 CDMA"
        case "iPhone4,1":                                return "iPhone 4S"
        case "iPhone5,1":                                return "iPhone 5 (GSM)"
        case "iPhone5,2":                                return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":                                return "iPhone 5C (GSM)"
        case "iPhone5,4":                                return "iPhone 5C (Global)"
        case "iPhone6,1":                                return "iPhone 5S (GSM)"
        case "iPhone6,2":                                return "iPhone 5S (Global)"
        case "iPhone7,2":                                return "iPhone 6"
        case "iPhone7,1":                                return "iPhone 6 Plus"
        case "iPhone8,1":                                return "iPhone 6s"
        case "iPhone8,2":                                return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                   return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                   return "iPhone 7 Plus"
        case "iPhone8,4":                                return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                 return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                 return "iPhone 8 Plus"
        case "iPhone10,3":                               return "iPhone X Global"
        case "iPhone10,6":                               return "iPhone X GSM"
        case "iPhone11,2":                               return "iPhone XS"
        case "iPhone11,4":                               return "iPhone XS Max"
        case "iPhone11,6":                               return "iPhone XS Max Global"
        case "iPhone11,8":                               return "iPhone XR"
        case "iPhone12,1":                               return "iPhone 11"
        case "iPhone12,3":                               return "iPhone 11 Pro"
        case "iPhone12,5":                               return "iPhone 11 Pro Max"
        case "iPhone12,8":                               return "iPhone SE (2nd generation)"
        case "iPhone13,1":                               return "iPhone 12 mini"
        case "iPhone13,2":                               return "iPhone 12"
        case "iPhone13,3":                               return "iPhone 12 Pro"
        case "iPhone13,4":                               return "iPhone 12 Pro Max"
        case "iPhone14,2":                               return "iPhone 13 Pro"
        case "iPhone14,3":                               return "iPhone 13 Pro Max"
        case "iPhone14,4":                               return "iPhone 13 Mini"
        case "iPhone14,5":                               return "iPhone 13"
// MARK: - iPads
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":            return "iPad (3rd generation)"
        case "iPad3,4", "iPad3,5", "iPad3,6":            return "iPad (4th generation)"
        case "iPad6,11", "iPad6,12":                     return "iPad (5th generation)"
        case "iPad7,5", "iPad7,6":                       return "iPad (6th generation)"
        case "iPad7,11", "iPad7,12":                     return "iPad (7th generation)"
        case "iPad4,1", "iPad4,2", "iPad4,3":            return "iPad Air"
        case "iPad5,3", "iPad5,4":                       return "iPad Air 2"
        case "iPad11,4", "iPad11,5":                     return "iPad Air (3rd generation)"
        case "iPad2,5", "iPad2,6", "iPad2,7":            return "iPad mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":            return "iPad mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":            return "iPad mini 3"
        case "iPad5,1", "iPad5,2":                       return "iPad mini 4"
        case "iPad11,1", "iPad11,2":                     return "iPad mini (5th generation)"
        case "iPad6,3", "iPad6,4":                       return "iPad Pro (9.7-inch)"
        case "iPad7,3", "iPad7,4":                       return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return "iPad Pro (11-inch)"
        case "iPad8,9", "iPad8,10":                      return "iPad Pro (11-inch) (2nd generation)"
        case "iPad6,7", "iPad6,8":                       return "iPad Pro (12.9-inch)"
        case "iPad7,1", "iPad7,2":                       return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,11", "iPad8,12":                     return "iPad Pro (12.9-inch) (4th generation)"
        case "AppleTV5,3":                               return "Apple TV"
        case "AppleTV6,2":                               return "Apple TV 4K"
        case "AudioAccessory1,1":                        return "HomePod"
        case "i386", "x86_64", "arm64":                  return "Simulator \(self.mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
        default:                                         return identifier
        }
        #elseif os(tvOS)
        switch identifier {
        case "AppleTV5,3":              return "Apple TV 4"
        case "AppleTV6,2":              return "Apple TV 4K"
        case "i386", "x86_64", "arm64": return "Simulator \(self.mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
        default:               return identifier
        }
        #endif
    }
}
