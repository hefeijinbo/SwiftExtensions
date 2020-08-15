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
    
    /// 关闭ScrollView自动调节insets功能
    func disableAdjustsScrollviewInsets(_ scrollview: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollview.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
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
    
    @objc func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
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
    
    /// 从基本视图控制器中获得最顶层的视图控制器;默认参数是UIWindow的rootViewController
    @objc static func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
