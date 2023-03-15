import Foundation
import LotteryManagerSDK

struct ExtraDozenGame {
    let concurso: Int
    let data: String
    let proxData: String
    let rateioOn: Bool
    let dezenas: [String]
    let trevos: [Int]
}

extension ExtraDozenGame: LMContestServiceType {
    
    var isCompleted: Bool {
        rateioOn == false
    }
    
    var extraDozen: [String] { trevos.map( { "0\($0.description)" }) }
    
    var contestNumber: Int {
        concurso
    }
    
    var nextGameDate: String {
        proxData
    }
    
    var gameDate: String {
        data
    }
    
    var game: LMGameType {
        .extraDozen(.init(id: contestNumber.description,
                          dozens: dezenas,
                          extraDozen: extraDozen))
    }
    
    func getPrizeFor(game: LMGameType) -> Double {
        switch game {
        case .extraDozen:
            return 1.0
        default:
            fatalError("Mais Milionaria game should not implement other types")
        }
    }
}

struct ExtraDozenGameConfigurator {
    static let minDozens: Int = 6
    static let maxDozens: Int = 12
    static let dozensTotalCount: Int = 50
    static let range: ClosedRange<Int> = 1...50
    
    static let minDozensExtra: Int = 2
    static let maxDozensExtra: Int = 6
    static let rangeExtra: ClosedRange<Int> = 1...6
}

extension ExtraDozenGameConfigurator: LMRulesProtocol {
    
    var gameRules: LMGameRulesType {
        .DozenContest(
            LMDozenContestRules(
                minDozens: Self.minDozens,
                maxDozens: Self.maxDozens,
                range: Self.range))
    }
    
    var extraValueRules: LMGameRulesType? {
        .DozenContest(
            LMDozenContestRules(
                minDozens: Self.minDozensExtra,
                maxDozens: Self.maxDozensExtra,
                range: Self.rangeExtra))
    }
    
    var teimosinha: [Int] {
        [1, 2, 3, 4, 5]
    }
    
    var priceArray: [[Double]] {
        [[6, 18, 36, 60, 90],
         [42, 126, 252, 420, 630],
         [168, 504, 1008, 1680, 2520],
         [504, 1512, 3024, 5040, 7560],
         [1260, 3780, 7560, 12600, 18900],
         [2772, 8316, 16632, 27720, 41580],
         [5544, 16632, 33264, 554440, 83160]]
    }
    
    func getPrice(for game: LMGameType) -> Double {
        switch game {
        case .extraDozen(let game):
            return priceArray[game.dozens.count - Self.minDozens][game.extraDozen.count - Self.minDozensExtra]
        default:
            fatalError("Mais Milionaria game should not implement other types")
        }
    }

}

extension ExtraDozenGameConfigurator: LMGameModelProtocol {
    func createGameModelType(form: LotteryManagerSDK.GameFormModelType) -> LotteryManagerSDK.LMGameModel {
        let keyGenerator = LMKeyGenerator()
        guard let dozens = form.dozens,
              let input = form.extraDozens else {
            fatalError("Form mounted wrong.")
        }
     let gameExtra = LMExtraDozenGame(id: keyGenerator.getRandom(),
                         dozens: dozens,
                         extraDozen: input)
     return LMGameModel(
        id: keyGenerator.getRandom(),
        type: .extraDozen(gameExtra))
    }
}


extension ExtraDozenGameConfigurator: LMSourceAPIType {
    var name: String {
        "maismilionaria"
    }
    
    // Not used yet
    var url: String {
        "www.google.com"
    }
}

