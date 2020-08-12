//
//  UIStoryboardExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    /// 使用类名实例化一个UIViewController
    ///
    /// - Parameter classType: UIViewController type
    func instantiateViewController<T: UIViewController>(classType: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: classType)) as? T
    }
}
