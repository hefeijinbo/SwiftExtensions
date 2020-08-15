//
//  UIViewExtensions+Animation.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/15.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

/// 平移方向
@objc public enum UIViewAnimationTranslationDirection: Int {
    case leftToRight
    case rightToLeft
}

public extension UIView {
    /// 震动特效
    ///
    /// - Parameters:
    ///   - count: 震动次数
    ///   - duration: 震动持续时间
    ///   - translation: 震动位移
    @objc func shake(count: Float = 2, duration: TimeInterval = 0.15, translation: Float = 5) {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = (duration) / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation
        
        layer.add(animation, forKey: "shake")
    }
    
    /// 脉冲效果
    @objc func pulse(count: Float = 1, duration: TimeInterval = 1) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = count
        
        layer.add(animation, forKey: "pulse")
    }
    
    /// 心跳效果
    ///
    /// - Parameters:
    ///   - count: 动画的秒数
    ///   - maxSize: 缩放最大倍数
    ///   - durationPerBeat: 每次心跳时长
    @objc func heartbeat(count: Float = 1, maxSize: CGFloat = 1.4, durationPerBeat: TimeInterval = 0.5) {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        
        let scale1 = CATransform3DMakeScale(0.8, 0.8, 1)
        let scale2 = CATransform3DMakeScale(maxSize, maxSize, 1)
        let scale3 = CATransform3DMakeScale(maxSize - 0.3, maxSize - 0.3, 1)
        let scale4 = CATransform3DMakeScale(1.0, 1.0, 1)
        
        let frameValues = [NSValue(caTransform3D: scale1), NSValue(caTransform3D: scale2), NSValue(caTransform3D: scale3), NSValue(caTransform3D: scale4)]
        
        animation.values = frameValues
        
        let frameTimes = [NSNumber(value: 0.05), NSNumber(value: 0.2), NSNumber(value: 0.6), NSNumber(value: 1.0)]
        animation.keyTimes = frameTimes
        
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = durationPerBeat
        animation.repeatCount = count / Float(durationPerBeat)
        
        layer.add(animation, forKey: "heartbeat")
    }
    
    /// 翻转效果
    ///
    /// - Parameters:
    ///   - duration: 动画时长
    ///   - direction: 翻转方向
    @objc func flip(duration: TimeInterval, direction: CATransitionSubtype) {
        let transition = CATransition()
        transition.subtype = direction
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType(rawValue: "flip")
        transition.duration = duration
        transition.repeatCount = 1
        transition.autoreverses = true
        
        layer.add(transition, forKey: "flip")
    }
    
    /// 在topView周围平移UIView。
    ///
    /// - Parameters:
    ///   - topView: 平移相对view
    ///   - duration: 平移时长
    ///   - direction: 平移方向
    ///   - repeatAnimation: 动画是否重复
    ///   - startFromEdge: 动画从边缘开始
    @objc func translateAround(topView: UIView, duration: CGFloat, direction: UIViewAnimationTranslationDirection, repeatAnimation: Bool = true, startFromEdge: Bool = true) {
        var startPosition: CGFloat = center.x, endPosition: CGFloat
        switch direction {
        case .leftToRight:
            startPosition = frame.size.width / 2
            endPosition = -(frame.size.width / 2) + topView.frame.size.width

        case .rightToLeft:
            startPosition = -(frame.size.width / 2) + topView.frame.size.width
            endPosition = frame.size.width / 2
        }
        
        if startFromEdge {
            center = CGPoint(x: startPosition, y: center.y)
        }
        
        UIView.animate(
            withDuration: TimeInterval(duration / 2),
            delay: 1,
            options: UIView.AnimationOptions(),
            animations: {
                self.center = CGPoint(x: endPosition, y: self.center.y)
            }, completion: { finished in
                if finished {
                    UIView.animate(
                        withDuration: TimeInterval(duration / 2),
                        delay: 1,
                        options: UIView.AnimationOptions(),
                        animations: {
                            self.center = CGPoint(x: startPosition, y: self.center.y)
                        }, completion: { finished in
                            if finished {
                                if repeatAnimation {
                                    self.translateAround(topView: topView, duration: duration, direction: direction, repeatAnimation: repeatAnimation, startFromEdge: startFromEdge)
                                }
                            }
                        }
                    )
                }
            }
        )
    }
    
    /// 沿着路径动画。
    ///
    /// - Parameters:
    ///   - path: 路径
    ///   - count: 动画重复次数
    ///   - duration: 动画时长
    @objc func animate(path: UIBezierPath, count: Float = 1, duration: TimeInterval, autoreverses: Bool = false) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.repeatCount = count
        animation.duration = duration
        animation.autoreverses = autoreverses
        
        layer.add(animation, forKey: "animateAlongPath")
    }
}
