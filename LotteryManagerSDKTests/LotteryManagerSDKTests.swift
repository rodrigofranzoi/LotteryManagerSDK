//
//  LotteryManagerSDKTests.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//

import XCTest
@testable import LotteryManagerSDK

final class LotteryManagerSDKTests: XCTestCase {
    
    let sut = LMGameModel(id: "simpleId", type: .extraDozen(.init(id: "simpleId", dozens: ["1"], extraDozen: ["5"])))

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let mock = SimpleLotteryMock()
        
        XCTAssertEqual(mock.getPrice(for: sut.type), 3.0)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
