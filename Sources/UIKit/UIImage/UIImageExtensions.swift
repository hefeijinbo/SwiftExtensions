//
//  UIImageExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/10.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit
import Accelerate

public extension UIImage {
    /// 创建一个旋转指定角度(以弧度为单位)的UIImage。
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: .pi)
    @objc func rotatImage(radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        UIGraphicsBeginImageContext(roundedDestRect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        context.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
    
    /// 混合指定图片
    ///
    /// - Parameters:
    ///   - otherImage: Image to be added to blend.
    ///   - blendMode: Blend Mode.
    /// - Returns: Returns the image.
    func blendImage(otherImage: UIImage, blendMode: CGBlendMode) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        
        draw(in: rect, blendMode: .normal, alpha: 1)
        otherImage.draw(in: rect, blendMode: blendMode, alpha: 1)
        
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        
        return result
    }

    /// 混合指定颜色(着色)
    @objc func tintImage(color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
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
        defer {
            UIGraphicsEndImageContext()
        }
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
    @objc func applyAlpha(_ alpha: CGFloat) -> UIImage {
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
    
    /// 对图像应用一个filter.
    /// https://developer.apple.com/library/prerelease/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/).
    ///
    /// - Parameters:
    ///   - name: filter 名称
    ///   - parameters: filter 的键和值。一个关键的例子是kCIInputCenterKey。
    func filterImage(name: String, parameters: [String: Any] = [:]) -> UIImage {
        let context = CIContext(options: nil)
        guard let filter = CIFilter(name: name), let ciImage = CIImage(image: self) else {
            return self
        }
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        for (key, value) in parameters {
            filter.setValue(value, forKey: key)
        }
        
        guard let outputImage = filter.outputImage,
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return self
        }
        
        let newImage = UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: imageOrientation)
        return newImage
    }
    
    /// 模糊效果
    ///
    /// - Parameters:
    ///   - blurRadius: 模糊半径
    ///   - saturation: 饱和度因子，如果你不知道它是什么，保留它的默认值(1.8)。
    ///   - tintColor: 模糊tint color，默认为nil。
    ///   - maskImage: 应用一个蒙版图像，如果你不想蒙版，保留默认值(nil)。
    /// - Returns: 返回转换后的图像。
    @objc func blurImage(radius: CGFloat,
                         saturation: CGFloat = 1.8,
                         tintColor: UIColor? = nil,
                         maskImage: UIImage? = nil) -> UIImage {
        guard size.width > 1 && size.height > 1, let selfCGImage = cgImage else {
            return self
        }
        
        let imageRect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        var effectImage = self
        
        let hasBlur = Float(radius) > Float.ulpOfOne
        let saturationABS = abs(saturation - 1)
        let saturationABSFloat = Float(saturationABS)
        let hasSaturationChange = saturationABSFloat > Float.ulpOfOne
        
        if hasBlur || hasSaturationChange {
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            guard let effectInContext = UIGraphicsGetCurrentContext() else {
                UIGraphicsEndImageContext()
                return self
            }
            effectInContext.scaleBy(x: 1, y: -1)
            effectInContext.translateBy(x: 0, y: -size.height)
            effectInContext.draw(selfCGImage, in: imageRect)
            var effectInBuffer = vImage_Buffer(data: effectInContext.data,
                                               height: UInt(effectInContext.height),
                                               width: UInt(effectInContext.width),
                                               rowBytes: effectInContext.bytesPerRow)
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            guard let effectOutContext = UIGraphicsGetCurrentContext() else {
                UIGraphicsEndImageContext()
                return self
            }
            var effectOutBuffer = vImage_Buffer(data: effectOutContext.data,
                                                height: UInt(effectOutContext.height),
                                                width: UInt(effectOutContext.width),
                                                rowBytes: effectOutContext.bytesPerRow)
            
            if hasBlur {
                var inputRadius = radius * UIScreen.main.scale
                let sqrt2PI = CGFloat(sqrt(2 * Double.pi))
                inputRadius = inputRadius * 3.0 * sqrt2PI / 4 + 0.5
                var radius = UInt32(floor(inputRadius))
                if radius % 2 != 1 {
                    radius += 1
                }
                
                let imageEdgeExtendFlags = vImage_Flags(kvImageEdgeExtend)
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil,
                                           0, 0, radius, radius, nil, imageEdgeExtendFlags)
                vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, nil,
                                           0, 0, radius, radius, nil, imageEdgeExtendFlags)
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil,
                                           0, 0, radius, radius, nil, imageEdgeExtendFlags)
            }
            
            if hasSaturationChange {
                let floatingPointSaturationMatrix = [
                    0.0722 + 0.9278 * saturation, 0.0722 - 0.0722 * saturation, 0.0722 - 0.0722 * saturation, 0,
                    0.7152 - 0.7152 * saturation, 0.7152 + 0.2848 * saturation, 0.7152 - 0.7152 * saturation, 0,
                    0.2126 - 0.2126 * saturation, 0.2126 - 0.2126 * saturation, 0.2126 + 0.7873 * saturation, 0,
                    0, 0, 0, 1
                ]
                
                let divisor: CGFloat = 256
                let saturationMatrix = floatingPointSaturationMatrix.map {
                    return Int16(round($0 * divisor))
                }
                
                if hasBlur {
                    vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer,
                                                  saturationMatrix, Int32(divisor), nil, nil,
                                                  vImage_Flags(kvImageNoFlags))
                } else {
                    vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer,
                                                  saturationMatrix, Int32(divisor), nil, nil,
                                                  vImage_Flags(kvImageNoFlags))
                }
            }
            
            guard let imageContext = UIGraphicsGetImageFromCurrentImageContext() else {
                return self
            }
            
            effectImage = imageContext
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let outputContext = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        outputContext.scaleBy(x: 1, y: -1)
        outputContext.translateBy(x: 0, y: -size.height)
        
        outputContext.draw(selfCGImage, in: imageRect)
        
        if hasBlur {
            outputContext.saveGState()
            
            if let maskImage = maskImage, let maskCGImage = maskImage.cgImage {
                outputContext.clip(to: imageRect, mask: maskCGImage)
            } else if let effectCGImage = effectImage.cgImage {
                outputContext.draw(effectCGImage, in: imageRect)
            }
            
            outputContext.restoreGState()
        }
        
        if let tintColor = tintColor {
            outputContext.saveGState()
            outputContext.setFillColor(tintColor.cgColor)
            outputContext.fill(imageRect)
            outputContext.restoreGState()
        }
        
        guard let outputImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        
        UIGraphicsEndImageContext()
        
        return outputImage
    }
}
