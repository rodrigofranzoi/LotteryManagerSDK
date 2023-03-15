//
//  LotteryManagerSDKTests.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//

import XCTest
@testable import LotteryManagerSDK

final class LMContestServiceTypeTests: XCTestCase {
    
    func testSimpleGameGetPrize() throws {
        let typePath =  Bundle(for: LMContestServiceTypeTests.self).path(forResource: "NormalGameType", ofType: "json")!
        let gamePath = Bundle(for: LMContestServiceTypeTests.self).path(forResource: "SimpleGameResponse", ofType: "json")!
        
        let sut: SimpleGame = loadFile(named: gamePath)
        let list: [LMGameType] = loadFile(named: typePath)
        
        for (index, game) in list.enumerated() {
            XCTAssertEqual(sut.getPrizeFor(game: game), Double(list.count-1 - index))
        }
    }
    
    func testMultipleGameGetPrizeTest() throws {
        let typePath =  Bundle(for: LMContestServiceTypeTests.self).path(forResource: "MultipleGameType", ofType: "json")!
        let gamePath = Bundle(for: LMContestServiceTypeTests.self).path(forResource: "MultipleGameResponse", ofType: "json")!
        
        let sut: MultipleGames = loadFile(named: gamePath)
        let list: [LMGameType] = loadFile(named: typePath)
        
        for (index, game) in list.enumerated() {
            XCTAssertEqual(sut.getPrizeFor(game: game), Double(list.count-1 - index))
        }
    }
}
