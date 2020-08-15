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
    
    @objc static var deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machine = systemInfo.machine
        var identifier = ""
        let mirror = Mirror(reflecting: machine)

        for child in mirror.children {
            let value = child.value

            if let value = value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }

        return identifier
    }
}
