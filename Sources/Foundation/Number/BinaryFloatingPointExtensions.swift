//
//  BinaryFloatingPointExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

/// 舍入规则
@objc public enum NumberRoundingRule: Int {
    case toNearestOrAwayFromZero = 0 // 标准教科书式四舍五入
    case toNearestOrEven // 银行家算法 四舍六入五取偶 五后非零就进一
    case upRule // 向上取整
    case down // 向下取整
    case towardZero // 接近0取整(截断truncate )
    case awayFromZero // 远离0取整
    
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

public extension BinaryFloatingPoint {
    /// 使用指定的舍入位置和舍入规则返回值。
    ///
    ///     let num = 3.1415927
    ///     num.rounded(decimalPlaces: 3, rule: .upRule) -> 3.142
    ///     num.rounded(decimalPlaces: 3, rule: .down) -> 3.141
    ///     num.rounded(decimalPlaces: 2, rule: .awayFromZero) -> 3.15
    ///     num.rounded(decimalPlaces: 4, rule: .towardZero) -> 3.1415
    ///     num.rounded(decimalPlaces: -1, rule: .toNearestOrEven) -> 3
    ///
    /// - Parameters:
    ///   - decimalPlaces: 舍入位置
    ///   - rule: 舍入规则
    func rounded(decimalPlaces: Int, rule: NumberRoundingRule) -> Self {
        let factor = Self(pow(10.0, Double(max(0, decimalPlaces))))
        return (self * factor).rounded(rule.roundingRule) / factor
    }
    
    func roundedString(decimalPlaces: Int, rule: NumberRoundingRule) -> String {
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
