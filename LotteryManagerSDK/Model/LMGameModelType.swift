//
//  GameModelType.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 16/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

// This protocol must conform with the data structure to save a game
public protocol LMGameModelType: Codable {
    var type: LMGameType { get }
}

public struct LMGameModel: LMGameModelType {
    public let type: LMGameType
    public let id: String
    
    public init(id: String, type: LMGameType) {
        self.id = id
        self.type = type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(LMGameType.self, forKey: .type)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    public func getDozens() -> [[String]] {
        switch type {
        case .extraDozen(let extraDozen):
            return [extraDozen.dozens]
        case .normal(let normal):
            return [normal.dozens]
        case .extraGame(let extraGame):
            return [extraGame.dozens]
        case .multipleGame(let multipleGame):
            return multipleGame.dozens
        }
    }
    
    public func getExtraDozens() -> [String]? {
        switch type {
        case .extraDozen(let extraDozen):
            return extraDozen.extraDozen
        case .normal, .extraGame, .multipleGame:
            return nil
        }
    }
    
    public func getExtraValue() -> String? {
        switch type {
        case .extraGame(let extraGame):
            return extraGame.extraValue
        case .normal, .extraDozen, .multipleGame:
            return nil
        }
    }
}
