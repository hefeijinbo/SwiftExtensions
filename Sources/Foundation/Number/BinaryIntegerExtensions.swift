//
//  BinaryIntegerExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/12.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension BinaryInteger {
    /// 根据整数类型字节数获得 bytes
    var bytesWithTypeCount: [UInt8] {
        let typeCount = bitWidth / 8
        return bytes(count: typeCount)
    }
    
    /// 获得整数指定数量的 bytes
    func bytes(count: Int) -> [UInt8] {
        if count == 0 {
            return []
        }
        var bytes = [UInt8]()
        for i in 0..<count {
            let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
            bytes.append(byte)
        }
        return bytes
    }
}
