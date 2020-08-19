//
//  URLExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import Foundation

public extension URL {
    var queryParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems else { return [:] }
        var items: [String: String] = [:]
        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }
        return items
    }
    
    /// "https://google.com" -> "https://google.com?q=Swifter%20Swift"
    @discardableResult
    mutating func appendQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = (urlComponents.queryItems ?? [])
            + parameters.map { URLQueryItem(name: $0, value: $1) }
        self = urlComponents.url!
        return self
    }

    func queryValue(for key: String) -> String {
        return URLComponents(string: absoluteString)?
            .queryItems?
            .first(where: { $0.name == key })?
            .value ?? ""
    }

    /// "https://domain.com/path/other" -> "https://domain.com/"
    func deletingAllPathComponents() -> URL {
        var url: URL = self
        for _ in 0..<pathComponents.count - 1 {
            url.deleteLastPathComponent()
        }
        return url
    }

    mutating func deleteAllPathComponents() {
        for _ in 0..<pathComponents.count - 1 {
            deleteLastPathComponent()
        }
    }

    /// "https://domain.com" -> "domain.com"
    func droppedScheme() -> URL? {
        if let scheme = scheme {
            let droppedScheme = String(absoluteString.dropFirst(scheme.count + 3))
            return URL(string: droppedScheme)
        }

        guard host != nil else { return self }

        let droppedScheme = String(absoluteString.dropFirst(2))
        return URL(string: droppedScheme)
    }
}

public extension NSURL {
    @objc var queryParameters: [String: String] {
        return (self as URL).queryParameters
    }
    
    /// "https://google.com" -> "https://google.com?q=Swifter%20Swift"
    @objc func appendQueryParameters(_ parameters: [String: String]) -> URL {
        var url = self as URL
        return url.appendQueryParameters(parameters)
    }

    @objc func queryValue(for key: String) -> String {
        return (self as URL).queryValue(for: key)
    }

    /// "https://domain.com/path/other" -> "https://domain.com/"
    @objc func deletingAllPathComponents() -> URL {
        return (self as URL).deletingPathExtension()
    }

    /// "https://domain.com" -> "domain.com"
    @objc func droppedScheme() -> URL? {
        return (self as URL).droppedScheme()
    }
}
