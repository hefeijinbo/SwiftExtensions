//
//  Log.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/14.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public func printLog<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
        let value = object
        let stringRepresentation: String
        if let value = value as? CustomDebugStringConvertible {
            stringRepresentation = value.debugDescription
        } else if let value = value as? CustomStringConvertible {
            stringRepresentation = value.description
        } else {
            stringRepresentation = "\(value)"
        }
        let fileURL = URL(string: file)?.lastPathComponent ?? "Unknown file"
        let queue = Thread.isMainThread ? "UI" : "BG"
        print("<\(queue)> \(fileURL) \(function)[\(line)]: " + stringRepresentation)
    #endif
}
