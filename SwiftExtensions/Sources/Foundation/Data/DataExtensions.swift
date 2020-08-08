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
    
    func string(encoding: String.Encoding = .utf8) -> String {
        return String(data: self, encoding: .utf8) ?? String()
    }
    
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}

public extension NSData {
    @objc var byteArray: [UInt8] {
        return (self as Data).byteArray
    }
    
    @objc func string() -> String {
        return (self as Data).string(encoding: .utf8)
    }
    
    @objc func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try (self as Data).jsonObject(options: options)
    }
}

#endif
