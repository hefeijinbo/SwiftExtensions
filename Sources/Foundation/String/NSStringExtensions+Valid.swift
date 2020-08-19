//
//  NSStringExtensions+Valid.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/18.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension NSString {
    @objc var isValidPhoneNumber: Bool {
        return (self as String).isValidPhoneNumber
    }
    
    @objc var isValidEmail: Bool {
        return (self as String).isValidEmail
    }
    
    @objc var isValidUrl: Bool {
        return (self as String).isValidUrl
    }
    
    /// 是否是数字
    @objc var isValidNumber: Bool {
        return (self as String).isValidNumber
    }
}
