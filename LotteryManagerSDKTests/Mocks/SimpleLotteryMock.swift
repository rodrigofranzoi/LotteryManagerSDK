//
//  SimpleLotteryMock.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//

import Foundation
import LotteryManagerSDK

class SimpleLotteryConfigMock: LMConfigurator {
    
    static let minDozens: Int = 1
    static let maxDozens: Int = 2
    static let dozensTotalCount: Int = 50
    
    static let minDozensExtra: Int = 1
    static let maxDozensExtra: Int = 2
    static let dozensExtraTotalCount: Int = 6
    
    let dummyId: String = "1234"
    let dozens1: [String] = ["1"]
    let dozens2: [String] = ["5"]
    
    
    // UI REQUIRED FUNCTION
    func isValid(form: LotteryManagerSDK.GameFormModelType) -> Bool {
        true
    }

    // UI REQUIRED FUNCTION
    func createGameModelType(form: LotteryManagerSDK.GameFormModelType) -> LotteryManagerSDK.LMGameModel {
        .init(id: dummyId, type: .extraDozen( .init(id: dummyId, dozens: dozens1, extraDozen: dozens2)))
    }
    
    var name: String {
        "simplelottery"
    }
    
    var url: String {
        "www.google.com"
    }
    
    var gameRules: LMGameRulesType {
          
        .DozenContest(
            LMDozenContestRules(
                minDozens: Self.minDozens,
                maxDozens: Self.maxDozens,
                range: 1...50))
    }
    
    var extraGameRules: LMGameRulesType? {
        .DozenContest(
            LMDozenContestRules(
                minDozens: Self.minDozensExtra,
                maxDozens: Self.maxDozensExtra,
                range: 1...6))
    }
    
    var teimosinha: [Int] = [1]
    var priceArray: [[Double]] = [[2.0, 3.0],
                                  [4.0, 5.0]]
    
    func getPrice(for game: LotteryManagerSDK.LMGameType) -> Double {
        switch game {
        case .extraDozen(let extraGame):
            return priceArray[extraGame.extraDozen.count - Self.minDozensExtra][extraGame.dozens.count - Self.minDozens]
        default:
            fatalError("Should not be implemented")
        }
    }
}


struct SimpleLotteryResultMock: LMContestServiceType {
    func getPrizeFor(games: [LotteryManagerSDK.LMGameType]) -> Double {
        return 10.0
    }
    
    var contestNumber: Int = 100
    
    var nextGameDate: String = "19/03/98"
    
    var gameDate: String = "19/04/96"
    
    var game: LotteryManagerSDK.LMGameType {
        .extraDozen(LMExtraDozenGame(id: "simpleId", dozens: ["1", "2", "3", "4", "5", "6"], extraDozen: ["1", "6"]))
    }
    
    func getPrizeFor(game: LotteryManagerSDK.LMGameType) -> Double {
        switch game {
        case .extraDozen:
            return 15.0
        default:
            fatalError()
        }
    }
    
    var isCompleted: Bool = true
    
    
}
