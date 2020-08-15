//
//  UIToolbarExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIToolbar {
    /// 设置UIToolbar是否透明
    @objc func setTransparent(_ transparent: Bool) {
        if transparent {
            setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
            setShadowImage(UIImage(), forToolbarPosition: .any)
        } else {
            setBackgroundImage(nil, forToolbarPosition: .any, barMetrics: .default)
            setShadowImage(nil, forToolbarPosition: .any)
        }
    }
}
