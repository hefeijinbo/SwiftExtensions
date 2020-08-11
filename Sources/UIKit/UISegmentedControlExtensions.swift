//
//  UISegmentedControlExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UISegmentedControl {
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
