//
//  DecodableExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension Decodable {
    /// data 解析成 Decodable 模型
    init?(jsonEncodeData: Data) {
        let decoder = JSONDecoder()
        guard let parsed = try? decoder.decode(Self.self, from: jsonEncodeData) else { return nil }
        self = parsed
    }
}
