//
//  DictionaryExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension Dictionary {
    func jsonData(pretty: Bool = false) throws -> Data {
        guard JSONSerialization.isValidJSONObject(self) else {
            throw SwiftExtensionsError.jsonError(reason: .invalidJSON)
        }
        let options = (pretty == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }
}
