//
//  UINavigationControllerExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UINavigationController {
    /// 使用新的 viewController 覆盖和替换当前 viewController
    @objc func replaceLastWithViewController(_ viewController: UIViewController, animated: Bool) {
        var array = viewControllers
        array.removeLast()
        array.append(viewController)
        setViewControllers(array, animated: animated)
    }
    
    /// 带 completion 回调的 pop
    @objc func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        guard let completion = completion else {
            popViewController(animated: animated)
            return
        }
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }

    /// 带 completion 回调的 push
    @objc func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        guard let completion = completion else {
            pushViewController(viewController, animated: true)
            return
        }
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
