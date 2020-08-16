//
//  BinaryFloatingPointExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension BinaryFloatingPoint {
    /// 使用指定的小数位数和四舍五入规则返回一个四舍五入值。如果“decimalPlaces”是负数，则使用“0”。
    ///
    ///     let num = 3.1415927
    ///     num.rounded(decimalPlaces: 3, rule: .up) -> 3.142
    ///     num.rounded(decimalPlaces: 3, rule: .down) -> 3.141
    ///     num.rounded(decimalPlaces: 2, rule: .awayFromZero) -> 3.15
    ///     num.rounded(decimalPlaces: 4, rule: .towardZero) -> 3.1415
    ///     num.rounded(decimalPlaces: -1, rule: .toNearestOrEven) -> 3
    ///
    func rounded(decimalPlaces: Int, rule: FloatingPointRoundingRule) -> Self {
        let factor = Self(pow(10.0, Double(max(0, decimalPlaces))))
        return (self * factor).rounded(rule) / factor
    }
    
    func roundedString(decimalPlaces: Int, rule: FloatingPointRoundingRule) -> String {
        if self == 0 {
            return "0"
        }
        if self.isNaN {
            return "NaN"
        }
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.maximumFractionDigits = decimalPlaces
        guard let number = self.rounded(decimalPlaces: decimalPlaces, rule: rule) as? NSNumber else {
            return "0"
        }
        return format.string(from: number) ?? "0"
    }
}

public extension NSNumber {
    @objc func rounded(decimalPlaces: Int, rule: NSFloatingPointRoundingRule) -> Double {
        return doubleValue.rounded(decimalPlaces: decimalPlaces, rule: rule.roundingRule)
    }
    
    @objc func roundedString(decimalPlaces: Int, rule: NSFloatingPointRoundingRule) -> String {
        return doubleValue.roundedString(decimalPlaces: decimalPlaces, rule: rule.roundingRule)
    }
}

@objc public enum NSFloatingPointRoundingRule: Int {
    case toNearestOrAwayFromZero = 0
    case toNearestOrEven
    case upRule
    case down
    case towardZero
    case awayFromZero
    
    var roundingRule: FloatingPointRoundingRule {
        let swiftMode: FloatingPointRoundingRule
        switch self {
        case .toNearestOrAwayFromZero:
            swiftMode = .toNearestOrAwayFromZero
        case .toNearestOrEven:
            swiftMode = .toNearestOrEven
        case .upRule:
            swiftMode = .up
        case .down:
            swiftMode = .down
        case .towardZero:
            swiftMode = .towardZero
        case .awayFromZero:
            swiftMode = .awayFromZero
        }
        return swiftMode
    }
}
