//
//  DateExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

extension Calendar.Component {
    static let dateTimeSet: Set<Calendar.Component> = [.year, .month, .day, .month, .hour,
                                                       .minute, .second, .weekday, .weekdayOrdinal]
}

public extension Date {
    var calendar: Calendar {
        return Calendar(identifier: .gregorian)
    }
    
    mutating func addDays(_ days: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = days
        guard let newDate = calendar.date(byAdding: dateComponents, to: self) else {
            return self
        }
        self = newDate
        return newDate
    }
    
    mutating func addMonths(_ months: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = months
        guard let newDate = calendar.date(byAdding: dateComponents, to: self) else {
            return self
        }
        self = newDate
        return newDate
    }
    
    mutating func addHours(_ hours: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.hour = hours
        guard let newDate = calendar.date(byAdding: dateComponents, to: self) else {
            return self
        }
        self = newDate
        return newDate
    }
    
    var daysInMonth: Int {
        let range = calendar.range(of: .day, in: .month, for: self)
        return range?.count ?? 1
    }
    
    func isEqualIgnoringTime(date: Date) -> Bool {
        let calendar = self.calendar
        let components1 = calendar.dateComponents(Calendar.Component.dateTimeSet, from: self)
        let components2 = calendar.dateComponents(Calendar.Component.dateTimeSet, from: date)
        return (components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day)
    }
    
    var era: Int {
        return calendar.component(.era, from: self)
    }
    
    /// 季度
    var quarter: Int {
        return calendar.component(.quarter, from: self)
    }
    
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }

    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }

    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }

    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }

    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }

    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }

    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }

    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }

    var nanosecond: Int {
        get {
            return calendar.component(.nanosecond, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentNanoseconds = calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds
            if let date = calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }

    var millisecond: Int {
        get {
            return calendar.component(.nanosecond, from: self) / 1_000_000
        }
        set {
            let nanoSeconds = newValue * 1_000_000
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(nanoSeconds) else { return }
            if let date = calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }

    var isInFuture: Bool {
        return self > Date()
    }

    var isInPast: Bool {
        return self < Date()
    }

    var isInToday: Bool {
        return calendar.isDateInToday(self)
    }

    var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }

    var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }

    var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }

    var isWorkday: Bool {
        return !calendar.isDateInWeekend(self)
    }

    var isInCurrentWeek: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    var isInCurrentMonth: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    var isInCurrentYear: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var yesterday: Date {
        return calendar.date(byAdding: .day, value: -1, to: self) ?? Date()
    }

    var tomorrow: Date {
        return calendar.date(byAdding: .day, value: 1, to: self) ?? Date()
    }
    
    static var is12HourTimeFormat: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        let dateString = dateFormatter.string(from: Date())
        return dateString.contains(dateFormatter.amSymbol) || dateString.contains(dateFormatter.pmSymbol)
    }
}

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
