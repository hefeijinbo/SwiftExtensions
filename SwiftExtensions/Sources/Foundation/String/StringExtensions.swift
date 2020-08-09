//
//  StringExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension String {
    var base64Decoded: String? {
        let remainder = count % 4
        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }
        guard let data = Data(base64Encoded: self + padding,
                              options: .ignoreUnknownCharacters) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    func date(format: String) -> Date? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: selfLowercased)
    }
    
    var isValidEmail: Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }

    /// 安全下标字符串在给定范围内。
    ///
    /// "Hello World!"[range: 6..<11] -> "World"
    func substring<R>(range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min..<Int.max)
        guard range.lowerBound >= 0,
            let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else {
                return nil
        }

        return String(self[lowerIndex..<upperIndex])
    }
    
    func substring(from index: Int, length: Int) -> String? {
        guard length >= 0, index >= 0, index < count  else { return nil }
        guard index.advanced(by: length) <= count else {
            return substring(range: index..<count)
        }
        guard length > 0 else { return "" }
        return substring(range: index..<index.advanced(by: length))
    }
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }

    var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
}

public extension NSString {
    @objc var base64Decoded: String? {
        return (self as NSString).base64Decoded
    }
    
    @objc var base64Encoded: String? {
        return (self as NSString).base64Encoded
    }
    
    @objc func date(format: String) -> Date? {
        return (self as NSString).date(format: format)
    }
    
    @objc var isValidEmail: Bool {
        return (self as NSString).isValidEmail
    }
    
    @objc var isValidUrl: Bool {
        return (self as NSString).isValidUrl
    }
}
