//
//  DateFormatterExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/19.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension DateFormatter {
    /// 统一的公历dateFormatter
    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.gregorian
        return formatter
    }
}
