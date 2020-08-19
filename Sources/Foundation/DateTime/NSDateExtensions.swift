//
//  NSDateExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/19.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension NSDate {
    @objc func addDays(_ days: Int) -> Date {
        var date = (self as Date)
        return date.addDays(days)
    }
    
    @objc func addMonths(_ months: Int) -> Date {
        var date = (self as Date)
        return date.addMonths(months)
    }
    
    @objc func isEqualIgnoringTime(date: Date) -> Bool {
        return (self as Date).isEqualIgnoringTime(date: date)
    }
    
    @objc var era: Int {
        return (self as Date).era
    }
    
    /// 季度
    @objc var quarter: Int {
        return (self as Date).quarter
    }
    
    @objc var weekOfYear: Int {
        return (self as Date).weekOfYear
    }
    
    @objc var weekOfMonth: Int {
        return (self as Date).weekOfMonth
    }

    @objc var year: Int {
        return (self as Date).year
    }

    @objc var month: Int {
        return (self as Date).month
    }

    @objc var day: Int {
        return (self as Date).day
    }

    @objc var weekday: Int {
        return (self as Date).weekday
    }

    @objc var hour: Int {
        return (self as Date).hour
    }

    @objc var minute: Int {
        return (self as Date).minute
    }

    @objc var second: Int {
        return (self as Date).second
    }

    @objc var nanosecond: Int {
        return (self as Date).nanosecond
    }

    @objc var millisecond: Int {
        return (self as Date).millisecond
    }

    @objc var isInFuture: Bool {
        return (self as Date).isInFuture
    }

    @objc var isInPast: Bool {
        return (self as Date).isInPast
    }

    @objc var isInToday: Bool {
        return (self as Date).isInToday
    }

    @objc var isInYesterday: Bool {
        return (self as Date).isInYesterday
    }

    @objc var isInTomorrow: Bool {
        return (self as Date).isInTomorrow
    }

    @objc var isInWeekend: Bool {
        return (self as Date).isInWeekend
    }

    @objc var isWorkday: Bool {
        return (self as Date).isWorkday
    }

    @objc var isInCurrentWeek: Bool {
        return (self as Date).isInCurrentWeek
    }

    @objc var isInCurrentMonth: Bool {
        return (self as Date).isInCurrentMonth
    }

    @objc var isInCurrentYear: Bool {
        return (self as Date).isInCurrentYear
    }

    @objc func string(format: String) -> String {
        return (self as Date).string(format: format)
    }
    
    @objc var yesterday: Date {
        return (self as Date).yesterday
    }

    @objc var tomorrow: Date {
        return (self as Date).tomorrow
    }
    
    @objc static var is12HourTimeFormat: Bool {
        return Date.is12HourTimeFormat
    }
}
