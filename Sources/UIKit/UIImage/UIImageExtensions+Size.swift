//
//  UIImageExtensions+Size.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIImage {
    @objc var bytesSize: Int {
        return pngData()?.count ?? 0
    }
    
    /// 压缩图片
    ///
    /// - Parameter quality: JPEG图像的质量，表示为从0.0到1.0的值。值0.0表示最大压缩(或最低质量)，值1.0表示最小压缩(或最佳质量)(默认值为0.5)。
    @objc func compress(quality: CGFloat) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }
    @objc func compressData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    
    /// 压缩图片质量和尺寸
    @objc func compress(toByte maxLength: Int) -> Data? {
        let image: UIImage = self
        var compression: CGFloat = 1
        if let data = image.jpegData(compressionQuality: compression), data.count < maxLength {
            return data
        }
        
        // Compress by quality
        var max: CGFloat = 1
        var min: CGFloat = 0
        var data: Data!
        for _ in 0 ..< 6 {
            compression = (max + min) / 2
            data = image.jpegData(compressionQuality: compression)
            if nil != data {
                if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                    min = compression
                } else if data.count > maxLength {
                    max = compression
                } else {
                    break
                }
            }
        }
        if data != nil && data.count < maxLength {
            return data
        }
        var resultImage: UIImage! = UIImage(data: data)

        // Compress by size
        var lastDataLength: Int = 0
        while resultImage != nil && data.count > maxLength, data.count != lastDataLength {
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(maxLength) / CGFloat(data.count)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                      height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = resultImage.jpegData(compressionQuality: compression)!
        }
        return data
    }
    
    /// 裁剪为指定CGRect大小
    @objc func crop(to rect: CGRect) -> UIImage {
        guard rect.size.width <= size.width && rect.size.height <= size.height else { return self }
        let scaledRect = rect.applying(CGAffineTransform(scaleX: scale, y: scale))
        guard let image = cgImage?.cropping(to: scaledRect) else { return self }
        return UIImage(cgImage: image, scale: scale, orientation: imageOrientation)
    }

    /// 等宽高比缩放到指定高度。
    ///
    /// - Parameters:
    ///   - toHeight: 新高度
    ///   - opaque: 指示位图是否不透明的标志。
    @objc func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 等宽高比缩放到指定宽度。
    @objc func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
