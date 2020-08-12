//
//  DictionaryExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension Dictionary {
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    func print() {
        let json = try? jsonString(pretty: true)
        Swift.print(json ?? "")
    }
    
    mutating func removeAll<S: Sequence>(keys: S) where S.Element == Key {
        keys.forEach { removeValue(forKey: $0) }
    }
    
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
    
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }

    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1}
    }
}

public extension NSDictionary {
    @objc func has(key: NSObject) -> Bool {
        return (self as Dictionary).has(key: key)
    }
    
    @objc func jsonData(pretty: Bool = false) throws -> Data {
        return try (self as Dictionary).jsonData(pretty: pretty)
    }
    
    @objc func jsonString(pretty: Bool = false) throws -> String {
        return try (self as Dictionary).jsonString(pretty: pretty)
    }
    
    @objc func print() {
        let json = try? jsonString(pretty: true)
        Swift.print(json ?? "")
    }
}

public extension NSMutableDictionary {
    @objc func removeAll(keys: [Any]) {
        keys.forEach { removeObject(forKey: $0) }
    }
}
