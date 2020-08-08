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
}

public extension NSNumber {
    @objc func rounded(decimalPlaces: Int, mode: NSFloatingPointRoundingRule) -> Double {
        let swiftMode: FloatingPointRoundingRule
        switch mode {
        case .toNearestOrAwayFromZero:
            swiftMode = .toNearestOrAwayFromZero
        case .toNearestOrEven:
            swiftMode = .toNearestOrEven
        case .up:
            swiftMode = .up
        case .down:
            swiftMode = .down
        case .towardZero:
            swiftMode = .towardZero
        case .awayFromZero:
            swiftMode = .awayFromZero
        }
        return doubleValue.rounded(decimalPlaces: decimalPlaces, rule: swiftMode)
    }
}

@objc public enum NSFloatingPointRoundingRule: Int {
    case toNearestOrAwayFromZero = 0
    case toNearestOrEven
    case up
    case down
    case towardZero
    case awayFromZero
}
