//
//  LotteryRulesProtocol.swift.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 14/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

// This define the behaviour of the lottery
public protocol LMRulesProtocol {
    var gameRules: LMGameRulesType { get }
    var extraValueRules: LMGameRulesType? { get }
    var teimosinha: [Int] { get }
    var priceArray: [[Double]] { get }
    
    func getPrice(for game: LMGameType) -> Double
    func getPrice(for games: [LMGameType]) -> Double
}

public extension LMRulesProtocol {
    func getPrice(for games: [LMGameType]) -> Double {
        var spent = 0.0
        games.forEach { spent += getPrice(for: $0) }
        return spent
    }
}

public protocol LMDozenContestRulesType {
    var minDozens: Int { get }
    var maxDozens: Int { get }
    var range: ClosedRange<Int> { get }
    var dozensTotalCount: Int { get }
    func getFooterLabel() -> String
}


public struct LMDozenContestRules: LMDozenContestRulesType {
    public var minDozens: Int
    public var maxDozens: Int
    public var range: ClosedRange<Int>
    
    public var dozensTotalCount: Int {
        range.count
    }
    
    public init(minDozens: Int, maxDozens: Int, range: ClosedRange<Int>) {
        self.minDozens = minDozens
        self.maxDozens = maxDozens
        self.range = range
    }
    
    public func getFooterLabel() -> String {
        if minDozens == maxDozens {
            return "Escolha \(minDozens) números."
        } else {
            return "Escolha de \(minDozens) a \(maxDozens) números."
        }
    }
}

public enum LMGameRulesType {
    case MultipleDozens([LMDozenContestRules])
    case DozenContest(LMDozenContestRules)
    case SingleTicketContest
}
