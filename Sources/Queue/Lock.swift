//
//  Lock.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public func synchronized(lock: AnyObject, work: () -> Void) {
    objc_sync_enter(lock)
    work()
    objc_sync_exit(lock)
}
