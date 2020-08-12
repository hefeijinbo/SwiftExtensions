//
//  DispatchQueueExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Dispatch
import Foundation

public extension DispatchQueue {
    // 安全的同步调用,防止死锁
    func syncSafe(_ execute: () -> Void) {
        if label == String(cString: __dispatch_queue_get_label(nil)) {
            execute()
            return
        }
        sync(execute: execute)
    }
    
    func asyncSafe(_ execute: @escaping () -> Void) {
        if self === DispatchQueue.main && Thread.isMainThread {
            execute()
        } else {
            async(execute: execute)
        }
    }
    
    static var isMainQueue: Bool {
        enum Static {
            static var key: DispatchSpecificKey<Void> = {
                let key = DispatchSpecificKey<Void>()
                DispatchQueue.main.setSpecific(key: key, value: ())
                return key
            }()
        }
        return DispatchQueue.getSpecific(key: Static.key) != nil
    }
    
    /// 当前队列是否为指定队列。
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()
        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }
        return DispatchQueue.getSpecific(key: key) != nil
    }
    
    func asyncAfter(delay: Double,
                    qos: DispatchQoS = .unspecified,
                    flags: DispatchWorkItemFlags = [],
                    execute work: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, qos: qos, flags: flags, execute: work)
    }
}
