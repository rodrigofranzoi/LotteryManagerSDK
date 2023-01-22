//
//  SimpleLotteryMock.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//

import Foundation
import LotteryManagerSDK

class SimpleLotteryMock: LMConfigurator {
    let dummyId: String = "1234"
    let dozens1: [String] = ["1"]
    let dozens2: [String] = ["5"]
    
    func isValid(form: LotteryManagerSDK.GameFormModelType) -> Bool {
        true
    }

    func createGameModelType(form: LotteryManagerSDK.GameFormModelType) -> LotteryManagerSDK.LMGameModel {
        .init(id: dummyId, type: .extraDozen( .init(id: dummyId, dozens: dozens1, extraDozen: dozens2)))
    }
    
    var name: String {
        "simplelottery"
    }
    
    var url: String {
        "www.google.com"
    }
    
    var gameRules: LotteryManagerSDK.GameRulesType {
        .DozenContest(DozenContestRules(minDozens: 1, maxDozens: 1, dozensTotalCount: 60))
    }
    
    var extraGameRules: LotteryManagerSDK.GameRulesType? {
        .DozenContest(DozenContestRules(minDozens: 1, maxDozens: 1, dozensTotalCount: 60))
    }
    
    var teimosinha: [Int] = [1]
    var priceArray: [[Double]] = [[0.0, 2.0, 3.0]]
    
    func getPrice(for game: LotteryManagerSDK.LMGameType) -> Double {
        switch game {
        case .extraDozen(let extraDozen):
            let first = dozens1.contains { $0 == extraDozen.dozens[0] } ? 1 : 0
            let second = dozens2.contains { $0 == extraDozen.extraDozen[0] } ? 1 : 0
            return priceArray[0][first + second]
        default:
            fatalError("Should not be implemented")
        }
    }
}
