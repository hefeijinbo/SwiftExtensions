//
//  UIFontExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/10.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIFont {
    /// 系统字体加粗
    @objc var systemBold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }

    /// 系统字体斜体
    @objc var systemItalic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }
}
