//
//  DataExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

#if canImport(Foundation)
import Foundation

public extension Data {
    var byteArray: [UInt8] {
        return [UInt8](self)
    }
    
    func subdata(from index: Int) -> Data {
        if index >= count {
            return Data()
        }
        return subdata(in: index..<count)
    }
    
    func subdata(to index: Int) -> Data {
        if index == 0 {
            return Data()
        }
        if index > count {
            return Data()
        }
        return subdata(in: 0..<index)
    }
    
    func subdata(location: Int, length: Int) -> Data {
        if length == 0 {
            return Data()
        }
        var lastIndex = location + length
        if lastIndex > count {
            lastIndex = count - 1
        }
        return self.subdata(in: location..<lastIndex)
    }
    
    func string(encoding: String.Encoding = .utf8) -> String {
        let str = String(data: self, encoding: .utf8) ?? String()
        if !str.contains("\0") {
            return str
        }
        return str.replacingOccurrences(of: "\0", with: "")
    }
    
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}

public extension NSData {
    @objc func subdata(from index: Int) -> Data {
        return (self as Data).subdata(from: index)
    }
    
    @objc func subdata(to index: Int) -> Data {
        return (self as Data).subdata(to: index)
    }
    
    @objc func subdata(location: Int, length: Int) -> Data {
        return (self as NSData).subdata(location: location, length: length)
    }
    
    @objc var byteArray: [UInt8] {
        return (self as Data).byteArray
    }
    
    @objc func utf8tring() -> String {
        return (self as Data).string(encoding: .utf8)
    }
    
    @objc func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try (self as Data).jsonObject(options: options)
    }
}

#endif
