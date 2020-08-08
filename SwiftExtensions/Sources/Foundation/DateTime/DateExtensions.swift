//
//  DateExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

#if canImport(Foundation)
import Foundation

public extension Date {
    
    /// 返回在当月的第几天。
    /// - Returns: 天数
    var numberOfDaysInMonth: Int {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: self)!.count
    }
}

public extension NSDate {
    
    /// 返回在当月的第几天。
    /// - Returns: 天数
    @objc var numberOfDaysInMonth: Int {
        return (self as Date).numberOfDaysInMonth
    }
}
#endif
