//
//  UIScreenExtensions.swift
//  SwiftExtensions
//
//  Created by yons on 2020/8/13.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIScreen {
    @objc static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    @objc static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
