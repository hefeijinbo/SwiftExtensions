//
//  CALayerExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension CALayer {
    @objc var snapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}
