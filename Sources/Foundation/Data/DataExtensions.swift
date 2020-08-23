//
//  DataExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension Data {
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
            return self
        }
        return subdata(in: 0..<index)
    }
    
    func subdata(location: Int, length: Int) -> Data {
        if length == 0 {
            return Data()
        }
        if location >= count {
            return Data()
        }
        var lastIndex = location + length
        if lastIndex > count {
            lastIndex = count - 1
        }
        return self.subdata(in: location..<lastIndex)
    }
    
    var utf8String: String? {
        return String(data: self, encoding: .utf8)
    }
    
    /// 使用 JSONSerialization 解析出 Cocoa 类型
    func jsonSerializationObject() throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: [.allowFragments])
    }
    
    /// 使用 JSONDecoder 解析出对象类型
    func jsonDecodeObject<T: Decodable>(classType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        let obj = try decoder.decode(T.self, from: self)
        return obj
    }
    
    /// 字节数组
    var byteArray: [UInt8] {
        return [UInt8](self)
    }
    
    /// 十六进制字符串显示
    var hexString: String {
        let bytes = [UInt8](self)
        var hex = ""
        for byte in bytes {
            hex += String(format: "%02X", byte)
        }
        return hex
    }
}
