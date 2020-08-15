//
//  ErrorExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
