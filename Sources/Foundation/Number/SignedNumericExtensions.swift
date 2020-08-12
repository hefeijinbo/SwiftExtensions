//
//  SignedNumericExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension SignedNumeric {
    var currencyString: String {
        let number = self as? NSNumber ?? NSNumber()
        return number.currencyString
    }
    
    var decimalString: String {
        let number = self as? NSNumber ?? NSNumber()
        return number.decimalString
    }
}

public extension NSNumber {
    @objc var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: self) ?? ""
    }
    
    /// 1000_0000
    @objc var decimalString: String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(from: self) ?? "0"
    }
}
