//
//  NSStringExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/18.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit
import CoreGraphics

public extension NSString {
    @objc var md5CryptoString: String {
        return (self as String).md5CryptoString
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
