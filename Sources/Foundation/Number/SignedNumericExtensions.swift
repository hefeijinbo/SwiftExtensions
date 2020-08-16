//
//  SignedNumericExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension SignedNumeric {
    /// $1,234.57  1 234,57 €
    var currencyString: String {
        let number = self as? NSNumber ?? NSNumber()
        return number.currencyString
    }
    
    /// 1,234.5678
    var decimalString: String {
        let number = self as? NSNumber ?? NSNumber()
        return number.decimalString
    }
}
