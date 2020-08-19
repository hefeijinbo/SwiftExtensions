//
//  UISegmentedControlExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UISegmentedControl {
    /// 解决 iOS 13 设置 tintColor 无效问题
    @objc func changeTintColor(_ color: UIColor) {
        if #available(iOS 13, *) {
            let tintColorImage = UIImage(color: tintColor)
            setBackgroundImage(UIImage(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
            setBackgroundImage(UIImage(color: tintColor.withAlphaComponent(0.2)),
                               for: .highlighted,
                               barMetrics: .default)
            setBackgroundImage(tintColorImage, for: [.highlighted, .selected], barMetrics: .default)
            let font = UIFont.systemFont(ofSize: 13, weight: .regular)
            setTitleTextAttributes([.foregroundColor: tintColor!, .font: font], for: .normal)
            setTitleTextAttributes([.foregroundColor: UIColor.white, .font: font], for: .selected)
            setDividerImage(tintColorImage,
                            forLeftSegmentState: .normal,
                            rightSegmentState: .normal,
                            barMetrics: .default)
            layer.borderWidth = 1
            layer.borderColor = tintColor.cgColor
        }
        tintColor = color
    }
    
    /// 标题文案
    @objc var segmentTitles: [String] {
        get {
            let range = 0..<numberOfSegments
            return range.compactMap { titleForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            for (index, title) in newValue.enumerated() {
                insertSegment(withTitle: title, at: index, animated: false)
            }
        }
    }

    /// 图片
    @objc var segmentImages: [UIImage] {
        get {
            let range = 0..<numberOfSegments
            return range.compactMap { imageForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            for (index, image) in newValue.enumerated() {
                insertSegment(with: image, at: index, animated: false)
            }
        }
    }
}
