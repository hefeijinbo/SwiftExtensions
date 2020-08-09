//
//  SwiftExtensionsError.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public enum SwiftExtensionsError: Error {
    public enum JSONErrorReason {
        case unknown
        case invalidJSON
        
        var errorDescription: String? {
            switch self {
            case .unknown:
                return "未知错误"
            case .invalidJSON:
                return "不合法的 JSON"
            }
        }
        
        var errorCode: Int {
            switch self {
            case .unknown: return 1001
            case .invalidJSON: return 1002
            }
        }
    }
    case jsonError(reason: JSONErrorReason)
    case invalidData
}

extension SwiftExtensionsError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .jsonError(let reason): return reason.errorDescription
        case .invalidData: return "包含非utf-8数据"
        }
    }
}

extension SwiftExtensionsError: CustomNSError {
    public static let errorDomain = "com.SwiftExtensions.Error"
    /// The error code within the given domain.
    public var errorCode: Int {
        switch self {
        case .jsonError(let reason): return reason.errorCode
        case .invalidData: return 1000
        }
    }
}
