//
//  StringExtensions+Valid.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/12.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension String {
    var isValidPhoneNumber: Bool {
        if self.count == 0 {
            return false
        }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        if regexMobile.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        if self.count == 0 {
            return false
        }
        let mobile = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        if regexMobile.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    /// 是否是数字
    var isValidNumber: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$").evaluate(with: self)
    }
    
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// 身份证
    var isIdCard: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^(\\d{14}|\\d{17})(\\d|[xX])$").evaluate(with: self)
    }
}

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
