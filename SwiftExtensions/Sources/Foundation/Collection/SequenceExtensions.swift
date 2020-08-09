//
//  SequenceExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension Sequence where Element: Equatable {
    /// 检查是否包含数组所有元素
    func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else { return true }
        for element in elements {
            if !contains(element) {
                return false
            }
        }
        return true
    }
}

public extension Sequence where Element: Numeric {
    func sum() -> Element {
        return reduce(into: 0, +=)
    }
}
