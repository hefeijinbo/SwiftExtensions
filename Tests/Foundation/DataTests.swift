//
//  DataTests.swift
//  Tests
//
//  Created by jinbo on 2020/8/16.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import XCTest

class DataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        let dic = ["name": "ming", "age": 5] as [String: Any]
        guard let data = try? dic.jsonData() else {
            return
        }
        guard let obj = DataJSONObject(jsonEncodeData: data) else {
            return
        }
        print(obj)
        guard let obj2 = try? data.jsonDecodeObject(classType: DataJSONObject.self) else {
            return
        }
        print(obj2)
    }

}

struct DataJSONObject: Codable {
    var name: String
    var age: Int
}
