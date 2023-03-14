//
//  LotteryProtocol.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 16/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

// This define the content retrieved by the source
public protocol LMContestServiceType: LMPersistenceType {
    var contestNumber: Int { get }
    var nextGameDate: String { get }
    var gameDate: String { get }
    var game: LMGameType { get }
    
    func getPrizeFor(game: LMGameType) -> Double
    func getPrizeFor(games: [LMGameType]) -> Double
}

public extension LMContestServiceType {
    func getPrizeFor(games: [LMGameType]) -> Double {
        var total: Double = 0.0
        games.forEach { total += getPrizeFor(game: $0) }
        return total
    }
}
