//
//  GameType.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 30/11/2022.
//  Copyright © 2022 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public enum LMGameType: Codable {
    case normal(LMNormalGame)
    case extraDozen(LMExtraDozenGame)
    case extraGame(LMExtraValueGame)
}

public extension LMGameType {
    private enum CodingKeys: String, CodingKey {
        case normal
        case extraDozen
        case extraGame
    }

    enum GameTypeCodingError: Error {
        case decoding(String)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(LMNormalGame.self, forKey: .normal) {
            self = .normal(value)
            return
        }
        if let value = try? values.decode(LMExtraDozenGame.self, forKey: .extraDozen) {
            self = .extraDozen(value)
            return
        }
        if let value = try? values.decode(LMExtraValueGame.self, forKey: .extraGame) {
            self = .extraGame(value)
            return
        }
        throw GameTypeCodingError.decoding("Failed to decode game! \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .normal(let game):
            try container.encode(game, forKey: .normal)
        case .extraGame(let game):
            try container.encode(game, forKey: .extraGame)
        case .extraDozen(let game):
            try container.encode(game, forKey: .extraDozen)
        }
    }
}
