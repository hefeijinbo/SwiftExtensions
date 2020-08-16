//
//  NSNumberExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/16.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension NSNumber {
    /// 使用指定的舍入位置和舍入规则返回值。
    ///
    ///     let num = NSNumber(value: 3.1415927)
    ///     num.rounded(decimalPlaces: 3, rule: .upRule) -> 3.142
    ///     num.rounded(decimalPlaces: 3, rule: .down) -> 3.141
    ///     num.rounded(decimalPlaces: 2, rule: .awayFromZero) -> 3.15
    ///     num.rounded(decimalPlaces: 4, rule: .towardZero) -> 3.1415
    ///     num.rounded(decimalPlaces: -1, rule: .toNearestOrEven) -> 3
    ///
    /// - Parameters:
    ///   - decimalPlaces: 舍入位置
    ///   - rule: 舍入规则
    @objc func rounded(decimalPlaces: Int, rule: NumberRoundingRule) -> Double {
        return doubleValue.rounded(decimalPlaces: decimalPlaces, rule: rule)
    }
    
    @objc func roundedString(decimalPlaces: Int, rule: NumberRoundingRule) -> String {
        return doubleValue.roundedString(decimalPlaces: decimalPlaces, rule: rule)
    }
    
    /// $1,234.57  1 234,57 €
    @objc var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: self) ?? ""
    }
    
    /// 1,234.5678
    @objc var decimalString: String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(from: self) ?? "0"
    }
    
    /// 获得整数指定数量的 bytes
    @objc func bytes(count: Int) -> [UInt8] {
        return int64Value.bytes(count: count)
    }
}
