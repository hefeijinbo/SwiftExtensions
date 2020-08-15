//
//  ArrayExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension Array {
    func jsonData(pretty: Bool = false) throws -> Data {
        guard JSONSerialization.isValidJSONObject(self) else {
            throw SwiftExtensionsError.jsonError(reason: .invalidJSON)
        }
        let options = (pretty == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    func jsonString(pretty: Bool = false) throws -> String {
        let data = try jsonData(pretty: pretty)
        guard let string = String(data: data, encoding: .utf8) else {
            throw SwiftExtensionsError.invalidData
        }
        return string
    }
    
    /// 在给定的指数位置安全地交换值。
    ///
    /// [1, 2, 3, 4, 5].safeSwap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
    ///
    mutating func safeSwap(from index: Int, to otherIndex: Int) {
        guard index != otherIndex else { return }
        guard startIndex..<endIndex ~= index else { return }
        guard startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }
}

public extension Array where Element: Equatable {
    /// 从数组中删除items包含的所有实例。
    @discardableResult
    mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }
    
    /// 删除数组中所有重复的元素。
    @discardableResult
    mutating func removeDuplicates() -> [Element] {
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }
    
    /// 交集
    func intersection(_ values: [Element]...) -> Array {
        var result = self
        var intersection = Array()

        for (i, value) in values.enumerated() {
            if i > 0 {
                result = intersection
                intersection = Array()
            }

            value.forEach { (item: Element) -> Void in
                if result.contains(item) {
                    intersection.append(item)
                }
            }
        }
        return intersection
    }
    
    /// 并集
    func union(_ values: [Element]...) -> Array {
        var result = self
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        return result
    }
}

public extension NSArray {
    @objc func jsonData(pretty: Bool = false) throws -> Data {
        return try (self as Array).jsonData(pretty: pretty)
    }
    
    @objc func jsonString(pretty: Bool = false) throws -> String {
        return try (self as Array).jsonString(pretty: pretty)
    }
}
