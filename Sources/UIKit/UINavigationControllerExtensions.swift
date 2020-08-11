//
//  UINavigationControllerExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UINavigationController {
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
