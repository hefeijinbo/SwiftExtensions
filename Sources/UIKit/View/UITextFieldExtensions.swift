//
//  UITextFieldExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UITextField {
    @objc func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    /// 添加左边空白间距
    @discardableResult
    @objc func addLeftBlank(padding: CGFloat) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = view
        leftViewMode = .always
        return view
    }

    /// 添加右边空白间距
    @discardableResult
    @objc func addPaddingRight(padding: CGFloat) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightView = view
        rightViewMode = .always
        return view
    }

    /// 添加左侧 Label
    @discardableResult
    @objc func addLeftLabel(text: String, textColor: UIColor, padding: CGFloat) -> UILabel {
        let labelFrame = CGRect(x: -padding, y: 0, width: text.boundingRectWidth(fontSize: 14), height: frame.height)
        let label = UILabel(frame: labelFrame)
        label.text = text
        label.textColor = textColor
        leftView = label
        leftViewMode = .always
        return label
    }
    
    /// 添加右侧 Label
    @discardableResult
    @objc func addRightLabel(text: String, textColor: UIColor, padding: CGFloat) -> UILabel {
        let labelFrame = CGRect(x: padding, y: 0, width: text.boundingRectWidth(fontSize: 14), height: frame.height)
        let label = UILabel(frame: labelFrame)
        label.text = text
        label.textColor = textColor
        rightView = label
        rightViewMode = .always
        return label
    }
    
    /// 添加左侧 imageView
    @discardableResult
    @objc func addLeftImageView(image: UIImage, padding: CGFloat) -> UIImageView {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        leftView = iconView
        leftViewMode = .always
        return imageView
    }

    /// 添加右侧 imageView
    @discardableResult
    @objc func addRightImageView(image: UIImage, padding: CGFloat) -> UIImageView {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        rightView = iconView
        rightViewMode = .always
        return imageView
    }
}
