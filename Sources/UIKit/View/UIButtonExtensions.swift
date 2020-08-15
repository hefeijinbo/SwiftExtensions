//
//  UIButtonExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/10.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIButton {
    /// 设置背景颜色
    @objc func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    /// 居中对齐标题文本和图像
    /// - Parameters:
    ///   - imageAboveText: 设置为true将使图像在标题文本之上，默认为假，图像在文本的左边
    ///   - spacing: 标题文本和图像之间的间距。
    @objc func centerTextAndImage(imageAboveText: Bool = false, spacing: CGFloat) {
        if imageAboveText {
            guard
                let imageSize = imageView?.image?.size,
                let text = titleLabel?.text,
                let font = titleLabel?.font
                else { return }

            let titleSize = text.size(withAttributes: [.font: font])

            let titleOffset = -(imageSize.height + spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: titleOffset, right: 0.0)

            let imageOffset = -(titleSize.height + spacing)
            imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0.0, bottom: 0.0, right: -titleSize.width)

            let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
            contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        } else {
            let insetAmount = spacing / 2
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
    
    /// 设置文本相对图像的对齐位置
    /// - Parameters:
    ///   - imageAboveText: 设置为true将使图像在标题文本之上，默认为假，图像在文本的左边
    ///   - spacing: 标题文本和图像之间的间距。
    @objc func positionLabelRespectToImage(position: UIView.ContentMode, spacing: CGFloat) {
        let imageSize = imageRect(forContentRect: self.frame)
        let titleFont = titleLabel?.font ?? UIFont.systemFont(ofSize: 14.0)
        let titleSize = titleLabel?.text?.size(withAttributes: [.font: titleFont]) ?? CGSize.zero
        
        var titleInsets: UIEdgeInsets!
        var imageInsets: UIEdgeInsets!
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
    func addTarget(events: UIControl.Event, action: @escaping (UIButton) -> Void) {
        setAssociatedObject(key: "UIButtonClickKey", value: action)
        addTarget(self, action: #selector(_btnClickAction), for: events)
    }
    
    @objc func _btnClickAction() {
        if let action = getAssociatedObject(key: "UIButtonClickKey") as? (UIButton) -> Void {
            DispatchQueue.main.async {
                action(self)
            }
        }
    }
}
