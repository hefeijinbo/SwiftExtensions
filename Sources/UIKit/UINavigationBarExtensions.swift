//
//  UINavigationBarExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    @objc func setTitleColor(color: UIColor, titleFont: UIFont) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.foregroundColor] = color
        attrs[.font] = titleFont
        titleTextAttributes = attrs
    }

    /// 文字颜色和背景色
    @objc func setTitleColor(_ oolor: UIColor, backgroundColor: UIColor) {
        isTranslucent = false
        self.backgroundColor = backgroundColor
        barTintColor = backgroundColor
        setBackgroundImage(UIImage(), for: .default)
        tintColor = oolor
        titleTextAttributes = [.foregroundColor: oolor]
    }

    /// 透明
    @objc func setTransparent(tintColor: UIColor) {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        self.tintColor = tintColor
        titleTextAttributes = [.foregroundColor: tintColor]
        shadowImage = UIImage()
    }
}
