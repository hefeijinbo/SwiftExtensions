//
//  StringExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit
import CommonCrypto

public extension String {
    var MD5CryptoString: String {
        let cStrl = cString(using: String.Encoding.utf8)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStrl, UInt32(strlen(cStrl!)), buffer)
        var string = ""
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx])
            string.append(obcStrl)
        }
        free(buffer)
        return string
    }
    
    func boundingRectWidth(fontSize: CGFloat) -> CGFloat {
        return (self as NSString).boundingRectWidth(fontSize: fontSize)
    }
    
    var jsonDic: [String: Any] {
        guard let data = data(using: .utf8) else {
            return [:]
        }
        let dic = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        return dic
    }
    
    var jsonDicArray: [[String: Any]] {
        guard let data = data(using: .utf8) else {
            return []
        }
        let array = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] ?? []
        return array ?? []
    }
    
    var intValue: Int {
        if let value = Int(self) {
            return value
        }
        if let value = Double(self) {
            return Int(value)
        }
        return 0
    }
    
    var doubleValue: Double {
        if let value = Double(self) {
            return value
        }
        return 0.0
    }
    
    var base64Decoded: String? {
        let remainder = count % 4
        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }
        guard let data = Data(base64Encoded: self + padding,
                              options: .ignoreUnknownCharacters) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    func date(format: String) -> Date? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: selfLowercased)
    }

    /// 安全下标字符串在给定范围内。
    ///
    /// "Hello World!"[range: 6..<11] -> "World"
    func substring<R>(range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min..<Int.max)
        guard range.lowerBound >= 0,
            let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else {
                return nil
        }

        return String(self[lowerIndex..<upperIndex])
    }
    
    func substring(from index: Int, length: Int) -> String? {
        guard length >= 0, index >= 0, index < count  else { return nil }
        guard index.advanced(by: length) <= count else {
            return substring(range: index..<count)
        }
        guard length > 0 else { return "" }
        return substring(range: index..<index.advanced(by: length))
    }
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }

    var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
    
    /// 文字转图片
    func toTextImage(fontSize: CGFloat, textColor: UIColor) -> UIImage? {
        let imgHeight: CGFloat = 16.0
        let imgWidth = boundingRectWidth(fontSize: fontSize)
        let attributeStr = NSAttributedString(string: self, attributes: [.font: fontSize, .foregroundColor: textColor])
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imgWidth, height: imgHeight), false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setCharacterSpacing(10.0)
        context.setTextDrawingMode(CGTextDrawingMode.fill)
        context.setFillColor(UIColor.white.cgColor)
        
        attributeStr.draw(in: CGRect(x: 0.0, y: 0.0, width: imgWidth, height: imgHeight))
        
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImg
    }
    
    /// 生成二维码
    ///
    /// - Parameters:
    ///   - centerImg: 中间的小图
    func createQRCode(centerImg: UIImage?) -> UIImage? {
        if isEmpty {
            return nil
        }
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(data(using: String.Encoding.utf8, allowLossyConversion: true), forKey: "inputMessage")
        guard let image = filter.outputImage else {
            return nil
        }
        let size: CGFloat = 300.0
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height),
                                  bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace,
                                  bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        guard let bitmapImage: CGImage = context.createCGImage(image, from: integral) else {
            return nil
        }
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion)
        bitmapRef.draw(bitmapImage, in: integral)
        guard let cgImage: CGImage = bitmapRef.makeImage() else {
            return nil
        }
        var qrCodeImage = UIImage(cgImage: cgImage)
        if let centerImg = centerImg {
            // 图片拼接
            UIGraphicsBeginImageContextWithOptions(qrCodeImage.size, false, UIScreen.main.scale)
            qrCodeImage.draw(in: CGRect(x: 0.0, y: 0.0, width: qrCodeImage.size.width, height: qrCodeImage.size.height))
            centerImg.draw(in: CGRect(x: (qrCodeImage.size.width - 35.0) / 2.0,
                                      y: (qrCodeImage.size.height - 35.0) / 2.0,
                                      width: 35.0, height: 35.0))
            
            qrCodeImage = UIGraphicsGetImageFromCurrentImageContext() ?? qrCodeImage
            UIGraphicsEndImageContext()
            return qrCodeImage
        } else {
            return qrCodeImage
        }
    }
}

public extension NSString {
    @objc var MD5CryptoString: String {
        return (self as String).MD5CryptoString
    }
    
    /// 计算显示宽度
    @objc func boundingRectWidth(fontSize: CGFloat) -> CGFloat {
        return boundingRect(with: CGSize(width: CGFloat.infinity, height: 40),
                            attributes: [.font: UIFont.systemFont(ofSize: fontSize)],
                            context: nil).width
    }
    
    @objc var jsonDic: [String: Any] {
        return (self as String).jsonDic
    }
    
    @objc var jsonDicArray: [[String: Any]] {
        return (self as String).jsonDicArray
    }
    
    @objc var base64Decoded: String? {
        return (self as String).base64Decoded
    }
    
    @objc var base64Encoded: String? {
        return (self as String).base64Encoded
    }
    
    @objc func date(format: String) -> Date? {
        return (self as String).date(format: format)
    }
    
    /// 生成二维码
      ///
      /// - Parameters:
      ///   - centerImg: 中间的小图
    func createQRCode(centerImg: UIImage?) -> UIImage? {
        return (self as String).createQRCode(centerImg: centerImg)
    }
}
