//
//  Tests.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import XCTest
@testable import SwiftExtensions

class Tests: XCTestCase {

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
        // This is an example of a performance test case.
        let desc = String(describing: TestViewController.self)
        print(desc)
        let dic = ["name1": "小王", "name2": "小刘", "name3": "小明"]

        dic.print()
        do {
            _ = try [5: 4].jsonData()
            print(" Hello world ".trimmingCharacters(in: .whitespacesAndNewlines))
        } catch let error {
            print(error)
        }
    }

}

class TestViewController: UIViewController {
    
}
