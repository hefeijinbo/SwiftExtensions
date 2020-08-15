//
//  UIImageExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/10.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIImage {
    /// 创建一个旋转指定角度(以弧度为单位)的UIImage。
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: .pi)
    @objc func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 应用给定的混合模式。
    ///
    /// - Parameters:
    ///   - image: Image to be added to blend.
    ///   - blendMode: Blend Mode.
    /// - Returns: Returns the image.
    func blend(image: UIImage, blendMode: CGBlendMode) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        
        draw(in: rect, blendMode: .normal, alpha: 1)
        image.draw(in: rect, blendMode: blendMode, alpha: 1)
        
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        UIGraphicsEndImageContext()
        
        return result
    }

    /// 着色
    @objc func tint(color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
        let drawRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    /// 填充前景色
    @objc func fillColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 填充背景色, 所有 alpha < 1 的位置可以看到背景色
    @objc func fillBackgroundColor(_ backgroundColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        backgroundColor.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        draw(at: .zero)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    /// 设置图片透明度
    func applyAlpha(_ alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return self}
        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -area.height)
        context.setBlendMode(.multiply)
        context.setAlpha(alpha)
        context.draw(self.cgImage!, in: area)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        return image
    }

    /// 添加圆角
    ///
    /// - Parameters:
    ///   - radius: 如果半径设置0, 使用最大半径 min(size.width, size.height) / 2
    @objc func addRoundedCorners(radius: CGFloat) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
