//
//  UISearchBarExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UISearchBar {
    /// 内置 TextField
    @objc var insideTextField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
}
