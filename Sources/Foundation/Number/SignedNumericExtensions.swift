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
        // swiftlint:disable:next force_cast
        (self as! NSNumber).currencyString
    }
}

public extension NSNumber {
    @objc var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        // swiftlint:disable:next force_cast
        return formatter.string(from: self) ?? ""
    }
}
