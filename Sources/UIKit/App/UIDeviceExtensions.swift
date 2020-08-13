//
//  UIDeviceExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/13.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIScreen {
    @objc static let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    @objc static let isPhone: Bool = UIDevice.current.userInterfaceIdiom == .phone
}
