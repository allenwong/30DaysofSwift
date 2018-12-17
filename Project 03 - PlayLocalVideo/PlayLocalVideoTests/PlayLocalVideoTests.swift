//
//  PlayLocalVideoTests.swift
//  PlayLocalVideoTests
//
//  Created by qianyb on 2018/12/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import XCTest

class PlayLocalVideoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let path1 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path2 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        // path1:file:///var/mobile/Containers/Data/Application/AACC81C6-8FAD-4F61-9925-9EF252092BA6/Documents/
        // path2:/var/mobile/Containers/Data/Application/AACC81C6-8FAD-4F61-9925-9EF252092BA6/Documents
        guard path1.absoluteString == path2 else {
            print("为啥不一样")
            return
        }
        print("不会不一样")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
