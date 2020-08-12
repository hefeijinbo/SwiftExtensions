//
//  NSObjectTests.swift
//  Tests
//
//  Created by jinbo on 2020/8/13.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import XCTest

class NSObjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        print(String(describing: NSDate.self))
        print(String(describing: Date.self))
        print(NSStringFromClass(NSDate.self))
        print(String(describing: TestViewController.self))
        print(NSStringFromClass(TestViewController.self))
    }

}
