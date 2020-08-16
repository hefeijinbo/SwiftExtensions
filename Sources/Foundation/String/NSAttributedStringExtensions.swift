//
//  NSAttributedStringExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    @objc convenience init(string: String, foregroundColor: UIColor, systemFontSize: CGFloat) {
        let font = UIFont.systemFont(ofSize: systemFontSize)
        self.init(string: string, attributes: [.foregroundColor: foregroundColor, .font: font])
    }
    
    @objc var medium: NSAttributedString {
        return applying(attributes: [.font: UIFont.systemFont(ofSize: currentFontSize, weight: .medium)])
    }
    
    @objc var semibold: NSAttributedString {
        return applying(attributes: [.font: UIFont.systemFont(ofSize: currentFontSize, weight: .semibold)])
    }
    
    /// 加粗
    @objc var bold: NSAttributedString {
        return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: currentFontSize)])
    }

    /// 下划线
    @objc var underline: NSAttributedString {
        return applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// 斜体
    @objc var italic: NSAttributedString {
        return applying(attributes: [.font: UIFont.italicSystemFont(ofSize: currentFontSize)])
    }

    /// 中划线
    @objc var strikethrough: NSAttributedString {
        return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    /// 颜色
    @objc func foregroundColor(_ color: UIColor) -> NSAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }
    
    /// 添加图片附件
    @objc func appendAttachment(_ image: String, bounds: CGRect) -> NSAttributedString {
        let attach = NSTextAttachment()
        attach.image = UIImage(named: image)
        attach.bounds = bounds
        let mutAttributed = NSMutableAttributedString(attributedString: self)
        mutAttributed.append(NSAttributedString(attachment: attach))
        return mutAttributed
    }

    /// 将属性应用于匹配正则表达式的子字符串
    ///
    /// - Parameters:
    ///   - attributes: 字典的属性
    ///   - pattern: 目标正则表达式
    ///   - options: 在匹配期间应用于表达式的正则表达式选项。看到NSRegularExpression可能值的选项。
    /// - Returns: 一个NSAttributedString，其属性应用于与模式匹配的子字符串
    @objc func applying(attributes: [NSAttributedString.Key: Any],
                        toRangesMatching pattern: String,
                        options: NSRegularExpression.Options = []) -> NSAttributedString {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: options) else { return self }

        let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
        let result = NSMutableAttributedString(attributedString: self)

        for match in matches {
            result.addAttributes(attributes, range: match.range)
        }
        return result
    }

    /// 将属性应用于给定字符串的匹配项
    ///
    /// - Parameters:
    ///   - attributes: 字典的属性
    ///   - target: 要应用的属性的子序列字符串
    /// - Returns: 在目标字符串上应用属性的NSAttributedString
    func applying<T: StringProtocol>(attributes: [NSAttributedString.Key: Any], toOccurrencesOf target: T) -> NSAttributedString {
        let pattern = "\\Q\(target)\\E"

        return applying(attributes: attributes, toRangesMatching: pattern)
    }
    
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }

    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }

    static func += (lhs: inout NSAttributedString, rhs: String) {
        lhs += NSAttributedString(string: rhs)
    }

    static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
        return lhs + NSAttributedString(string: rhs)
    }
}

extension NSAttributedString {
    @objc var attributes: [NSAttributedString.Key: Any] {
        guard self.length > 0 else { return [:] }
        return attributes(at: 0, effectiveRange: nil)
    }
    
    @objc func applying(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        let range = (string as NSString).range(of: string)
        copy.addAttributes(attributes, range: range)
        return copy
    }
    
    @objc var currentFontSize: CGFloat {
        guard let font = attributes[.font] as? UIFont else {
            return UIFont.systemFontSize
        }
        return font.pointSize
    }
}
