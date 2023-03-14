//
//  LotteryManagerSDKTests.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//

import XCTest
@testable import LotteryManagerSDK

final class LotteryManagerSDKTests: XCTestCase {
    
    var configurator: LMConfigurator!
    var simpleLottery: LMContestServiceType!
    
    override func setUp() {
        super.setUp()
        configurator = SimpleLotteryConfigurator()
        simpleLottery = SimpleLotteryGame(concurso: 100,
                                          data: "19/03/98",
                                          proxData: "19/04/96",
                                          rateioOn: false,
                                          dezenas: ["19", "12", "40", "42", "45", "50"])
    }
    
    func testGetPrize() throws {
        
        let sut = SimpleLotteryGame(concurso: 100,
                                          data: "19/03/98",
                                          proxData: "19/04/96",
                                          rateioOn: false,
                                          dezenas: ["19", "12", "40", "42", "45", "50"])
        
        let list = makeListLMGameType()
        
        for (index, game) in list.enumerated() {
            XCTAssertEqual(sut.getPrizeFor(game: game), Double(index))
        }
    }
    
    func testValidForm() throws {
        let path = Bundle(for: LotteryManagerSDKTests.self).path(forResource: "ValidForms", ofType: "json")!
        let forms: [LMFormMock] = loadFile(named: path)
        let sut = SimpleLotteryConfigurator()
        
        for form in forms {
            XCTAssertTrue(sut.isValid(form: form))
        }
    }
    
    func testInvalidForm() throws {
        let path = Bundle(for: LotteryManagerSDKTests.self).path(forResource: "InvalidForms", ofType: "json")!
        let forms: [LMFormMock] = loadFile(named: path)
        let sut = SimpleLotteryConfigurator()
        
        for form in forms {
            XCTAssertFalse(sut.isValid(form: form))
        }
    }
    
    func makeListLMGameType() -> [LMGameType] {
        let game6 = LMGameType.normal(.init(id: "simpleLotto",
                                          dozens: ["19", "12", "40", "42", "45", "50"]))
        let game5 = LMGameType.normal(.init(id: "simpleLotto",
                                          dozens: ["19", "12", "40", "42", "45", "06"]))
        let game4 = LMGameType.normal(.init(id: "simpleLotto",
                                          dozens: ["19", "12", "40", "42", "05", "06"]))
        let game3 = LMGameType.normal(.init(id: "simpleLotto",
                                          dozens: ["19", "12", "40", "04", "05", "06"]))
        let game2 = LMGameType.normal(.init(id: "simpleLotto",
                                          dozens: ["19", "12", "03", "04", "05", "06"]))
        let game1 = LMGameType.normal(.init(id: "simpleLotto",
                                          dozens: ["19", "02", "03", "04", "05", "06"]))
        let game0 = LMGameType.normal(.init(id: "simpleLotto",
                                          dozens: ["01", "02", "03", "04", "05", "06"]))
        return [game0, game1, game2, game3, game4, game5, game6]
    }
}


