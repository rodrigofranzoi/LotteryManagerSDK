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
        let form = LMFormMock(dozens: ["01", "12", "40", "42", "45", "60"], teimosinha: 1, number: 100, isRecurrent: false)
        let form1 = LMFormMock(dozens: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15"], teimosinha: 1, number: 100, isRecurrent: false)
        let sut = SimpleLotteryConfigurator()
        
        XCTAssertTrue(sut.isValid(form: form))
        XCTAssertTrue(sut.isValid(form: form1))
    }
    
    func testInvalidForm() throws {
        let form1 = LMFormMock(dozens: ["19", "12", "40", "42", "45"], teimosinha: 1, number: 100, isRecurrent: false)
        let form2 = LMFormMock(dozens: ["19", "12", "40", "42", "50", "90"], teimosinha: 1, number: 100, isRecurrent: false)
        let form3 = LMFormMock(dozens: ["00", "12", "40", "42", "50", "51"], teimosinha: 1, number: 100, isRecurrent: false)
        let form4 = LMFormMock(dozens: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16"], teimosinha: 1, number: 100, isRecurrent: false)
        
        let sut = SimpleLotteryConfigurator()
        
        XCTAssertFalse(sut.isValid(form: form1))
        XCTAssertFalse(sut.isValid(form: form2))
        XCTAssertFalse(sut.isValid(form: form3))
        XCTAssertFalse(sut.isValid(form: form4))
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


