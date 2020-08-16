//
//  NSDataExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/16.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension NSData {
    @objc func subdata(from index: Int) -> Data {
        return (self as Data).subdata(from: index)
    }
    
    @objc func subdata(to index: Int) -> Data {
        return (self as Data).subdata(to: index)
    }
    
    @objc func subdata(location: Int, length: Int) -> Data {
        return (self as Data).subdata(location: location, length: length)
    }
    
    @objc var utf8tring: String? {
        return (self as Data).utf8String
    }
    
    /// 使用 JSONSerialization 解析出 Cocoa 类型
    @objc func jsonSerializationObject() throws -> Any {
        return try (self as Data).jsonSerializationObject()
    }

    @objc var byteArray: [UInt8] {
        return (self as Data).byteArray
    }
}
