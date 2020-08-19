//
//  NSObjectExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/13.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension NSObject {
    /// 获得类名
    @objc static var stringFromClass: String {
        let string = NSStringFromClass(self)
        if string.contains(".") { // 针对 UIViewController 这种特殊情况
            return (string.components(separatedBy: ".").last) ?? ""
        } else {
            return string
        }
    }
    
    /// 动态添加属性
    ///
    /// - Parameters:
    ///   - key: 唯一值
    ///   - value: 保存的值
    @objc func setAssociatedObject(key: String, value: Any?) {
        guard let keyHashValue = UnsafeRawPointer(bitPattern: key.hashValue) else { return }
        objc_setAssociatedObject(self, keyHashValue, value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    /// 获取属性值
    ///
    /// - Parameter key: 唯一值
    /// - Returns: 保存的值
    @objc func getAssociatedObject(key: String) -> Any? {
        guard let keyHashValue = UnsafeRawPointer(bitPattern: key.hashValue) else { return nil }
        return objc_getAssociatedObject(self, keyHashValue)
    }
    
    /// 发送通知
    @objc func postNotification(name: String, object: Any?, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name),
                                        object: object, userInfo: userInfo)
    }
    
    /// 添加通知监听
    @objc func addNotificationObserver(_ selector: Selector, name: String, object: Any?) {
        NotificationCenter.default.addObserver(self, selector: selector,
                                               name: NSNotification.Name(rawValue: name),
                                               object: object)
    }
    
    @objc func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 获得所有属性和值的描述
    @objc var propertyDescription: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children.map { element -> String in
            let key = element.label ?? "Unknown"
            let value = element.value
            return "\(key): \(value)"
            }
            .joined(separator: "\n")
    }
}
