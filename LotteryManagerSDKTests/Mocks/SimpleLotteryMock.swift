//
//  SimpleLotteryMock.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//

import Foundation
import LotteryManagerSDK

struct SimpleGame {
    let concurso: Int
    let data: String
    let proxData: String
    let rateioOn: Bool
    let dezenas: [String]
}


extension SimpleGame: LMContestServiceType {

    static let getPrizeErrorMessage: String = "Simple Game should not implement other types"
    
    var contestNumber: Int {
        concurso
    }
    var nextGameDate: String {
        proxData
    }
    var gameDate: String {
        data
    }
    var game: LotteryManagerSDK.LMGameType {
        .normal(.init(id: concurso.description,
                      dozens: dezenas))
    }
    var isCompleted: Bool {
        rateioOn
    }
    
    // Returns the number of points
    func getPrizeFor(game: LotteryManagerSDK.LMGameType) -> Double {
        switch game {
        case .normal(let normalGame):
            return Double(Set(dezenas).intersection(Set(normalGame.dozens)).count)
        default:
            fatalError(Self.getPrizeErrorMessage)
        }
    }
    
}

struct SimpleGameConfigurator {
    static let minDozen: Int = 6
    static let maxDozen: Int = 15
    static let range: ClosedRange<Int> = 1...60
    
    static let getPriceErrorMessage: String = "Simple Game should not implement other types"
    static let createGameModelErrorMessage: String = "Simple Game form bad mounted"
    
}

extension SimpleGameConfigurator: LMRulesProtocol {
    var gameRules: LotteryManagerSDK.LMGameRulesType {
        .DozenContest(
            .init(
                minDozens: Self.minDozen,
                maxDozens: Self.maxDozen,
                range: Self.range))
    }
    
    var extraValueRules: LotteryManagerSDK.LMGameRulesType? { nil }
    
    var teimosinha: [Int] {
        [1, 2, 4, 8]
    }
    
    var priceArray: [[Double]] {
        [[4.50, 31.50, 126.00, 378.00, 945.00, 207900, 4158.00, 7722.00, 13513.50, 22522.50]]
    }
    
    func getPrice(for game: LotteryManagerSDK.LMGameType) -> Double {
        switch game {
        case .normal(let normalGame):
            return priceArray[0][normalGame.dozens.count-Self.minDozen]
        default:
            fatalError(Self.getPriceErrorMessage)
        }
    }
}

extension SimpleGameConfigurator: LMGameModelProtocol {
    func createGameModelType(form: LotteryManagerSDK.GameFormModelType) -> LotteryManagerSDK.LMGameModel {
        guard let dozens = form.dozens else {
            fatalError(Self.createGameModelErrorMessage)
        }
        return LMGameModel(id: "testID",
                           type: .normal(
                            .init(id: "testId",
                                  dozens: dozens)))
    }
}

extension SimpleGameConfigurator: LMSourceAPIType {
    var name: String {
        "Mega Sena"
    }
    
    var url: String {
        "www.dummy.com"
    }
}
