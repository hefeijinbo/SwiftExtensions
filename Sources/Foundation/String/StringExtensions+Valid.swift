//
//  StringExtensions+Valid.swift
//  SwiftExtensions
//
//  Created by yons on 2020/8/12.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension String {
    var isValidPhoneNumber: Bool {
        if self.count == 0 {
            return false
        }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
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
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    var isValidUrl: Bool {
         return URL(string: self) != nil
     }
}

public extension NSString {
    @objc var isValidPhoneNumber: Bool {
        return (self as NSString).isValidPhoneNumber
    }
    
    @objc var isValidEmail: Bool {
        return (self as NSString).isValidEmail
    }
    
    @objc var isValidUrl: Bool {
        return (self as NSString).isValidUrl
    }
}
