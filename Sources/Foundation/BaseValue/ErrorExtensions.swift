//
//  ErrorExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension Error {
    /// 错误码
    var code: Int { return (self as NSError).code }
    /// 错误域名
    var domain: String { return (self as NSError).domain }
}
