//
//  NSCalendarExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/19.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension NSCalendar {
    /// 统一的公历日历对象
    @objc static var gregorian: Calendar {
        return Calendar(identifier: .gregorian)
    }
}
