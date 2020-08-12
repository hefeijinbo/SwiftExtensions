//
//  NSObjectExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/13.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension NSObject {
    @objc static var stringFromClass: String {
        return (NSStringFromClass(self).components(separatedBy: ".").last) ?? ""
    }
    
    @objc func postNotification(name: String, object: Any?, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object,userInfo:userInfo )
    }
    
    @objc func addNotificationObserver(_ selector: Selector, name: String, object: Any?) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
    }
    
    @objc func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
