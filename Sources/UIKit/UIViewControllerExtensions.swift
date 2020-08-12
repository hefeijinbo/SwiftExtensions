//
//  UIViewControllerExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// 检查ViewController是否在屏幕上而不是隐藏。
    @objc var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }
    
    @objc func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        for childVC in self.children {
            childVC.removeFromParent()
            childVC.view.removeFromSuperview()
        }
        addChild(child)
        containerView.addSubviewToFillContent(child.view)
        child.didMove(toParent: self)
    }
    
    /// 以弹出窗口(popover)的形式呈现UIViewController。
    ///
    /// - Parameters:
    ///   - sourcePoint: 锚定弹出窗口的点
    @objc func presentPopover(_ popoverViewController: UIViewController, sourcePoint: CGPoint, delegate: UIPopoverPresentationControllerDelegate?, animated: Bool = true, completion: (() -> Void)?) {
        popoverViewController.modalPresentationStyle = .popover

        if let popoverPresentationVC = popoverViewController.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }

        present(popoverViewController, animated: animated, completion: completion)
    }
}
