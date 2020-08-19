//
//  UITableViewExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UITableView {
    /// headerView 自动适配高度
    @objc func tableHeaderViewSizeToFit() {
        tableHeaderOrFooterViewSizeToFit(\.tableHeaderView)
    }

    /// footerView 自动适配高度
    @objc func tableFooterViewSizeToFit() {
        tableHeaderOrFooterViewSizeToFit(\.tableFooterView)
    }

    /// 自动适配高度
    private func tableHeaderOrFooterViewSizeToFit(_ keyPath: ReferenceWritableKeyPath<UITableView, UIView?>) {
        guard let headerOrFooterView = self[keyPath: keyPath] else { return }
        let height = headerOrFooterView
            .systemLayoutSizeFitting(CGSize(width: frame.width, height: 0),
                                     withHorizontalFittingPriority: .required,
                                     verticalFittingPriority: .fittingSizeLevel).height
        guard headerOrFooterView.frame.height != height else { return }
        headerOrFooterView.frame.size.height = height
        self[keyPath: keyPath] = headerOrFooterView
    }
    
    /// 隐藏多余的线
    @objc func hiddeFooterLine() {
        tableFooterView = UIView()
    }
    
    @objc func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }

    @objc func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    
    @objc func scrollToRowSafe(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}
