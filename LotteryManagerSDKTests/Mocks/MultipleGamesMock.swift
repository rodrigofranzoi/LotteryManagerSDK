//
//  MultipleGamesMock.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 15/03/2023.
//

import Foundation
import LotteryManagerSDK

struct MultipleGames {
    let concurso: Int
    let data: String
    let proxData: String
    let rateioOn: Bool
    let dezenas: [String]
}


extension MultipleGames: LMContestServiceType {

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
                      dozens: strDezenas))
    }
    var isCompleted: Bool {
        rateioOn
    }
    
    var strDezenas: [String] {
        dezenas.map { "0\($0)" }
    }
    
    func getPrizeFor(game: LMGameType) -> Double {
        var points = 0
        switch game {
        case .multipleGame(let game):
            for (index, dezena) in strDezenas.enumerated() {
                for gameDozen in game.dozens[index] {
                    if gameDozen == dezena {
                        points += 1
                    }
                }
            }
            return Double(points)
        default:
            fatalError("Super Sete game should not implement other types")
        }
    }
    
}

struct MultipleGamesConfigurator {
    static let minDozens: Int = 1
    static let maxDozens: Int = 3
    static let numberOfGames: Int = 7
    static let range: ClosedRange<Int> = 0...9
}

extension MultipleGamesConfigurator: LotteryManagerSDK.LMRulesProtocol {
    
    var extraValueRules: LotteryManagerSDK.LMGameRulesType? {
        nil
    }
    
    var gameRules: LotteryManagerSDK.LMGameRulesType {
        .MultipleDozens((0..<Self.numberOfGames).map { _ in .init(minDozens: Self.minDozens, maxDozens: Self.maxDozens, range: Self.range) })
    }
    
    var teimosinha: [Int] {
        [1, 3, 6, 9, 12]
    }
    
    
    var priceArray: [[Double]] {
        [[2.50,
          5.00,
          10.00,
          20.00,
          40.00,
          80.00,
          160.00,
          320.00,
          480.00,
          720.00,
          1080.00,
          1620.00,
          2430.00,
          3645.00,
          5467.50]]
    }
    
    func getPrice(for game: LMGameType) -> Double {
        switch game {
        case .multipleGame(let game):
            var count = 0
            game.dozens.forEach { count += $0.count }
            return priceArray[0][count - Self.numberOfGames]
        default:
            fatalError("Super Sete game should not implement other types")
        }
    }
}

extension MultipleGamesConfigurator: LotteryManagerSDK.LMGameModelProtocol {
    func createGameModelType(form: LotteryManagerSDK.GameFormModelType) -> LotteryManagerSDK.LMGameModel {
        let keyGenerator = LMKeyGenerator()
        guard let dozens = form.multipleDozens else {
            fatalError("Form mounted wrong.")
        }

        return LMGameModel(
            id: keyGenerator.getRandom(),
            type: .multipleGame(
                LMMultipleGame(id: keyGenerator.getRandom(),
                               dozens: dozens)))
    }
}


extension MultipleGamesConfigurator: LotteryManagerSDK.LMSourceAPIType {
    var name: String {
        "supersete"
    }
    
    // Not used yet
    var url: String {
        "www.google.com"
    }
}
