//
//  RuntimeExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/14.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

///  打印类的所有实例变量
///
/// - Parameter cls: 目标类
public func printClassIvars(_ cls: AnyClass) {
    var count: UInt32 = 0
    let ivars = class_copyIvarList(cls, &count)
    print(cls)
    for i in 0 ..< count {
        let ivar = ivars![Int(i)]
        let name = String(utf8String: ivar_getName(ivar)!) ?? ""
        let typeString = String(utf8String: ivar_getTypeEncoding(ivar)!) ?? ""
        print("name: \(name) type: \(typeString)")
    }
    free(ivars)
}

///  打印类的所有属性变量
///
/// - Parameter cls: 目标类
public func printClassProperties(_ cls: AnyClass) {
    var count: UInt32 = 0
    let properties = class_copyPropertyList(cls, &count)
    print(cls)
    for i in 0 ..< count {
        let property = properties![Int(i)]
        let name = String(utf8String: property_getName(property)) ?? ""
        let attribute = String(utf8String: property_getAttributes(property)!) ?? ""
        print("name: \(name) attribute: \(attribute)")
    }
    free(properties)
}

/// 打印类的所有方法
///
/// - Parameter cls: 目标类
public func printClassMethods(_ cls: AnyClass) {
    var count: UInt32 = 0
    print(cls)
    let methods = class_copyMethodList(cls, &count)
    for i in 0 ..< count {
        let method = methods![Int(i)]
        print(method_getName(method))
    }
    free(methods)
}

/// Should be placed in dispatch_once or Load
public func swizzleInstanceMethod(for cls: AnyClass, original: Selector, override: Selector) {
    guard let originalMethod = class_getInstanceMethod(cls, original) else { return }
    guard let overrideMethod = class_getInstanceMethod(cls, override) else { return }
    if class_addMethod(cls, original,
                       method_getImplementation(overrideMethod),
                       method_getTypeEncoding(overrideMethod)) {
        class_replaceMethod(cls, override,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod)
    }
}

/// Should be placed in dispatch_once
public func swizzleClassMethod(for cls: AnyClass, original: Selector, override: Selector) {
    guard let originalMethod = class_getClassMethod(cls, original) else { return }
    guard let overrideMethod = class_getClassMethod(cls, override) else { return }
    
    if class_addMethod(
        cls,
        original,
        method_getImplementation(overrideMethod),
        method_getTypeEncoding(overrideMethod)) {
        class_replaceMethod(
            cls,
            override,
            method_getImplementation(originalMethod),
            method_getTypeEncoding(originalMethod)
        )
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod)
    }
}
