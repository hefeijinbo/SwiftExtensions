//
//  UIViewExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIView {
    @objc func addGradientLayer(startColor: UIColor,
                                endColor: UIColor,
                                startPoint: CGPoint = CGPoint(x: 0, y: 0),
                                endPoint: CGPoint = CGPoint(x: 0, y: 1)) {
        var gradientLayer: CAGradientLayer!
        for layer in layer.sublayers ?? [] {
            if let layer = layer as? CAGradientLayer {
                gradientLayer = layer
                break
            }
        }
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
            gradientLayer.frame = bounds
            layer.insertSublayer(gradientLayer, at: 0)
        }
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    /// 快照图片
    @objc var screenshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @objc var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    @objc var firstResponderView: UIView? {
        var views = [UIView](arrayLiteral: self)
        var index = 0
        repeat {
            let view = views[index]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            index += 1
        } while index < views.count
        return nil
    }
    
    /// 添加部分圆角
    @objc func addRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// 添加阴影
    ///
    /// - Note: 只适用于 non-clear 的背景色，或者视图设置了“shadowPath”。
    /// 详情请参阅参数“opacity”.
    ///
    /// - Parameters:
    ///   - opacity: 阴影不透明度(默认是0.5)。它也会受到背景色的alpha值的影响
    @objc func addShadow(color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    @objc func addSubviewToFillContent(_ subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    /// 视图边缘添加分割线
    @discardableResult
    @objc func addLine(direction: UIViewDirection, bgColor: UIColor, spacing: CGFloat) -> UIView {
        let line = UIView()
        addSubview(line)
        line.backgroundColor = bgColor
        switch direction {
        case .left:
            line.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            line.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing).isActive = true
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spacing).isActive = true
            line.widthAnchor.constraint(equalToConstant: 1).isActive = true
        case .right:
            line.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            line.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing).isActive = true
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spacing).isActive = true
            line.widthAnchor.constraint(equalToConstant: 1).isActive = true
        case .top:
            line.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            line.leftAnchor.constraint(equalTo: self.leftAnchor, constant: spacing).isActive = true
            line.rightAnchor.constraint(equalTo: self.rightAnchor, constant: spacing).isActive = true
            line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        case .bottom:
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            line.leftAnchor.constraint(equalTo: self.leftAnchor, constant: spacing).isActive = true
            line.rightAnchor.constraint(equalTo: self.rightAnchor, constant: spacing).isActive = true
            line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
        return line
    }
}

@objc public enum UIViewDirection: Int {
    case left = 0
    case right
    case top
    case bottom
}
