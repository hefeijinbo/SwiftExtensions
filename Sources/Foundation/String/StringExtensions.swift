//
//  StringExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit
import CommonCrypto

public extension String {
    var MD5CryptoString: String {
        let cStrl = cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, UInt32(strlen(cStrl!)), buffer);
        var string = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            string.append(obcStrl);
        }
        free(buffer);
        return string;
    }
    
    func boundingRectWidth(fontSize: CGFloat) -> CGFloat {
        return (self as NSString).boundingRectWidth(fontSize: fontSize)
    }
    
    var jsonDic: [String: Any] {
        guard let data = data(using: .utf8) else {
            return [:]
        }
        let dic = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        return dic
    }
    
    var jsonDicArray: [[String: Any]] {
        guard let data = data(using: .utf8) else {
            return []
        }
        let array = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] ?? []
        return array ?? []
    }
    
    var intValue: Int {
        if let value = Int(self) {
            return value
        }
        if let value = Double(self) {
            return Int(value)
        }
        return 0
    }
    
    var doubleValue: Double {
        if let value = Double(self) {
            return value
        }
        return 0.0
    }
    
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
    @objc var MD5CryptoString: String {
        return (self as String).MD5CryptoString
    }
    
    /// 计算显示宽度
    @objc func boundingRectWidth(fontSize: CGFloat) -> CGFloat {
        return boundingRect(with: CGSize(width: CGFloat.infinity, height: 40), attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).width
    }
    
    @objc var jsonDic: [String: Any] {
        return (self as NSString).jsonDic
    }
    
    @objc var jsonDicArray: [[String: Any]] {
        return (self as NSString).jsonDicArray
    }
    
    @objc var base64Decoded: String? {
        return (self as NSString).base64Decoded
    }
    
    @objc var base64Encoded: String? {
        return (self as NSString).base64Encoded
    }
    
    @objc func date(format: String) -> Date? {
        return (self as NSString).date(format: format)
    }
}
