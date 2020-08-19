//
//  CalendarExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/19.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension Calendar.Component {
    /// 标准日期集合 年月日时分秒
    static let dateTimeSet: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
}

public extension Calendar {
    /// 统一的公历日历对象
    static var gregorian: Calendar {
        return Calendar(identifier: .gregorian)
    }
}
