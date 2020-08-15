//
//  UIImageExtensions+Create.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIImage {
    /// 根据颜色创建UIImage
    @objc convenience init(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(rect)
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
    
    /// 从文本创建图片
    ///
    /// - Parameters:
    ///   - text: 文本.
    ///   - font: 字体.
    ///   - imageSize: 图片大小.
    convenience init?(text: String, font: UIFont, imageSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        
        text.draw(at: CGPoint(x: 0.0, y: 0.0), withAttributes: [.font: font])
        
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(), let cgImage = image.cgImage else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
    }
    
    /// 创建一个带有背景颜色的图像和带有蒙版的文本。
    ///
    /// - Parameters:
    ///   - maskedText: 用来蒙版的文本
    ///   - font: 文本字体
    ///   - imageSize: 图片大小
    ///   - backgroundColor: 背景颜色
    convenience init?(maskedText: String, font: UIFont, imageSize: CGSize, backgroundColor: UIColor) {
        let textAttributes = [NSAttributedString.Key.font: font]
        let textSize = maskedText.size(withAttributes: textAttributes)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(backgroundColor.cgColor)
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        context.addPath(path.cgPath)
        context.fillPath()
        
        context.setBlendMode(.destinationOut)
        let center = CGPoint(x: imageSize.width / 2 - textSize.width / 2, y: imageSize.height / 2 - textSize.height / 2)
        maskedText.draw(at: center, withAttributes: textAttributes)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(), let cgImage = image.cgImage else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
    }
}
