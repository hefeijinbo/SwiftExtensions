//
//  OperateQueueExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension OperationQueue {
    @objc static var isMainQueue: Bool {
        return DispatchQueue.isMainQueue
    }
    
    /// 当前队列是否为指定队列。
    @objc static func isCurrent(_ queue: OperationQueue) -> Bool {
        return current === queue
    }
}
