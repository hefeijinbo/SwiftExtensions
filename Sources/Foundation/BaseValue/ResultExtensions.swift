//
//  ResultExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension Result {
    /// 返回 failure 值
    var failure: Failure? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}
