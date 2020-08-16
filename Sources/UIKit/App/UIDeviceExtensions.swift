//
//  UIDeviceExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/13.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIDevice {
    @objc static let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    @objc static let isPhone: Bool = UIDevice.current.userInterfaceIdiom == .phone
    
    @objc static var majorVersion: Int {
        return Int(UIDevice.current.systemVersion.components(separatedBy: ".").first ?? "") ?? 0
    }
    
    @objc static var isIOS10: Bool {
        return majorVersion >= 10
    }
    
    @objc static var isIOS11: Bool {
        return majorVersion >= 11
    }
    
    @objc static var isIOS12: Bool {
        return majorVersion >= 12
    }
    
    @objc static var isIOS13: Bool {
        return majorVersion >= 13
    }
    
    static var modelType: DeviceModelType = DeviceModelType.currentType
    
    /// "iPhone8Plus" "iPhoneXSMax"
    @objc static var modelString: String {
        return modelType.rawValue
    }
}

public enum DeviceModelType: String {
    case iPodTouch5
    case iPodTouch6
    case iPodTouch7
    case iPhone4
    case iPhone4s
    case iPhone5
    case iPhone5c
    case iPhone5s
    case iPhone6
    case iPhone6Plus
    case iPhone6s
    case iPhone6sPlus
    case iPhone7
    case iPhone7Plus
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhoneSE2
    case iPad2
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPad5
    case iPad6
    case iPadAir3
    case iPad7
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadMini5
    case iPadPro9Inch
    case iPadPro12Inch
    case iPadPro12Inch2
    case iPadPro10Inch
    case iPadPro11Inch
    case iPadPro12Inch3
    case iPadPro11Inch2
    case iPadPro12Inch4
    case homePod
    case appleTVHD
    case appleTV4K
    case appleWatchSeries0With38mm
    case appleWatchSeries0With42mm
    case appleWatchSeries1With38mm
    case appleWatchSeries1With42mm
    case appleWatchSeries2With38mm
    case appleWatchSeries2With42mm
    case appleWatchSeries3With38mm
    case appleWatchSeries3With42mm
    case appleWatchSeries4With40mm
    case appleWatchSeries4With44mm
    case appleWatchSeries5With40mm
    case appleWatchSeries5With44mm
    case i386Simulator
    case x8664Simulator
    case unknown
    
    /// "iPhone7,1"
    static var currentIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    static var currentType: DeviceModelType {
        switch currentIdentifier {
        case "iPod5,1": return .iPodTouch5
        case "iPod7,1": return .iPodTouch6
        case "iPod9,1": return .iPodTouch7
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .iPhone4
        case "iPhone4,1": return .iPhone4s
        case "iPhone5,1", "iPhone5,2": return .iPhone5
        case "iPhone5,3", "iPhone5,4": return .iPhone5c
        case "iPhone6,1", "iPhone6,2": return .iPhone5s
        case "iPhone7,2": return .iPhone6
        case "iPhone7,1": return .iPhone6Plus
        case "iPhone8,1": return .iPhone6s
        case "iPhone8,2": return .iPhone6sPlus
        case "iPhone9,1", "iPhone9,3": return .iPhone7
        case "iPhone9,2", "iPhone9,4": return .iPhone7Plus
        case "iPhone8,4": return .iPhoneSE
        case "iPhone10,1", "iPhone10,4": return .iPhone8
        case "iPhone10,2", "iPhone10,5": return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6": return .iPhoneX
        case "iPhone11,2": return .iPhoneXS
        case "iPhone11,4", "iPhone11,6": return .iPhoneXSMax
        case "iPhone11,8": return .iPhoneXR
        case "iPhone12,1": return .iPhone11
        case "iPhone12,3": return .iPhone11Pro
        case "iPhone12,5": return .iPhone11ProMax
        case "iPhone12,8": return .iPhoneSE2
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3": return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6": return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3": return .iPadAir
        case "iPad5,3", "iPad5,4": return .iPadAir2
        case "iPad6,11", "iPad6,12": return .iPad5
        case "iPad7,5", "iPad7,6": return .iPad6
        case "iPad11,3", "iPad11,4": return .iPadAir3
        case "iPad7,11", "iPad7,12": return .iPad7
        case "iPad2,5", "iPad2,6", "iPad2,7": return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6": return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9": return .iPadMini3
        case "iPad5,1", "iPad5,2": return .iPadMini4
        case "iPad11,1", "iPad11,2": return .iPadMini5
        case "iPad6,3", "iPad6,4": return .iPadPro9Inch
        case "iPad6,7", "iPad6,8": return .iPadPro12Inch
        case "iPad7,1", "iPad7,2": return .iPadPro12Inch2
        case "iPad7,3", "iPad7,4": return .iPadPro10Inch
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPadPro11Inch
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPadPro12Inch3
        case "iPad8,9", "iPad8,10": return .iPadPro11Inch2
        case "iPad8,11", "iPad8,12": return .iPadPro12Inch4
        case "AudioAccessory1,1": return .homePod
        case "AppleTV5,3": return .appleTVHD
        case "AppleTV6,2": return .appleTV4K
        case "Watch1,1": return .appleWatchSeries0With38mm
        case "Watch1,2": return .appleWatchSeries0With42mm
        case "Watch2,6": return .appleWatchSeries1With38mm
        case "Watch2,7": return .appleWatchSeries1With42mm
        case "Watch2,3": return .appleWatchSeries2With38mm
        case "Watch2,4": return .appleWatchSeries2With42mm
        case "Watch3,1", "Watch3,3": return .appleWatchSeries3With38mm
        case "Watch3,2", "Watch3,4": return .appleWatchSeries3With42mm
        case "Watch4,1", "Watch4,3": return .appleWatchSeries4With40mm
        case "Watch4,2", "Watch4,4": return .appleWatchSeries4With44mm
        case "Watch5,1", "Watch5,3": return .appleWatchSeries5With40mm
        case "Watch5,2", "Watch5,4": return .appleWatchSeries5With44mm
        case "i386": return .i386Simulator
        case "x86_64": return .x8664Simulator
        default: return .unknown
        }
    }
}
