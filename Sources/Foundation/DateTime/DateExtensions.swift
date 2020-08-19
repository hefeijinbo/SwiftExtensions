//
//  DateExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension Date {
    mutating func addDays(_ days: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = days
        guard let newDate = Calendar.gregorian.date(byAdding: dateComponents, to: self) else {
            return self
        }
        self = newDate
        return newDate
    }
    
    mutating func addMonths(_ months: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = months
        guard let newDate = Calendar.gregorian.date(byAdding: dateComponents, to: self) else {
            return self
        }
        self = newDate
        return newDate
    }
    
    mutating func addHours(_ hours: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.hour = hours
        guard let newDate = Calendar.gregorian.date(byAdding: dateComponents, to: self) else {
            return self
        }
        self = newDate
        return newDate
    }
    
    var daysInMonth: Int {
        let range = Calendar.gregorian.range(of: .day, in: .month, for: self)
        return range?.count ?? 1
    }
    
    func isEqualIgnoringTime(date: Date) -> Bool {
        let calendar = Calendar.gregorian
        let components1 = calendar.dateComponents(Calendar.Component.dateTimeSet, from: self)
        let components2 = calendar.dateComponents(Calendar.Component.dateTimeSet, from: date)
        return (components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day)
    }
    
    var era: Int {
        return Calendar.gregorian.component(.era, from: self)
    }
    
    /// 季度
    var quarter: Int {
        return Calendar.gregorian.component(.quarter, from: self)
    }
    
    var weekOfYear: Int {
        return Calendar.gregorian.component(.weekOfYear, from: self)
    }
    
    var weekOfMonth: Int {
        return Calendar.gregorian.component(.weekOfMonth, from: self)
    }

    var year: Int {
        get {
            return Calendar.gregorian.component(.year, from: self)
        }
        set {
            let calendar = Calendar.gregorian
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
            return Calendar.gregorian.component(.month, from: self)
        }
        set {
            let allowedRange = Calendar.gregorian.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = Calendar.gregorian.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = Calendar.gregorian.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }

    var day: Int {
        get {
            return Calendar.gregorian.component(.day, from: self)
        }
        set {
            let calendar = Calendar.gregorian
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
        return Calendar.gregorian.component(.weekday, from: self)
    }

    var hour: Int {
        get {
            return Calendar.gregorian.component(.hour, from: self)
        }
        set {
            let calendar = Calendar.gregorian
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
            return Calendar.gregorian.component(.minute, from: self)
        }
        set {
            let calendar = Calendar.gregorian
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
            return Calendar.gregorian.component(.second, from: self)
        }
        set {
            let calendar = Calendar.gregorian
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
            return Calendar.gregorian.component(.nanosecond, from: self)
        }
        set {
            let calendar = Calendar.gregorian
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
            return Calendar.gregorian.component(.nanosecond, from: self) / 1_000_000
        }
        set {
            let calendar = Calendar.gregorian
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
        return Calendar.gregorian.isDateInToday(self)
    }

    var isInYesterday: Bool {
        return Calendar.gregorian.isDateInYesterday(self)
    }

    var isInTomorrow: Bool {
        return Calendar.gregorian.isDateInTomorrow(self)
    }

    var isInWeekend: Bool {
        return Calendar.gregorian.isDateInWeekend(self)
    }

    var isWorkday: Bool {
        return !Calendar.gregorian.isDateInWeekend(self)
    }

    var isInCurrentWeek: Bool {
        return Calendar.gregorian.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    var isInCurrentMonth: Bool {
        return Calendar.gregorian.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    var isInCurrentYear: Bool {
        return Calendar.gregorian.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    func string(format: String) -> String {
        let dateFormatter = DateFormatter.formatter
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var yesterday: Date {
        return Calendar.gregorian.date(byAdding: .day, value: -1, to: self) ?? Date()
    }

    var tomorrow: Date {
        return Calendar.gregorian.date(byAdding: .day, value: 1, to: self) ?? Date()
    }
    
    static var is12HourTimeFormat: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        let dateString = dateFormatter.string(from: Date())
        return dateString.contains(dateFormatter.amSymbol) || dateString.contains(dateFormatter.pmSymbol)
    }
}
