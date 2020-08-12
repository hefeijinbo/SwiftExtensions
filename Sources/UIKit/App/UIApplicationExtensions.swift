//
//  UIApplicationExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/10.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIApplication {

    /// 应用程序运行环境。
    ///
    /// - debug: 应用程序在调试模式下运行。
    /// - testFlight: 从Test Flight中安装应用程序。
    /// - appStore: 从App Store中安装应用程序。
    @objc enum Environment: Int {
        case debug
        case testFlight
        case appStore
    }

    @objc var currentEnvironment: Environment {
        #if DEBUG
        return .debug
        #elseif targetEnvironment(simulator)
        return .debug
        #else
        if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
            return .testFlight
        }

        guard let appStoreReceiptUrl = Bundle.main.appStoreReceiptURL else {
            return .debug
        }

        if appStoreReceiptUrl.lastPathComponent.lowercased() == "sandboxreceipt" {
            return .testFlight
        }

        if appStoreReceiptUrl.path.lowercased().contains("simulator") {
            return .debug
        }

        return .appStore
        #endif
    }

    /// App显示名称
    @objc var displayName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    /// App 版本号
    @objc var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// App 当前 build 版本号
    @objc var buildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

}
