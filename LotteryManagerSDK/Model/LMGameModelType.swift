//
//  GameModelType.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 16/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public struct LMMetaData: Codable {
    let createdAt: String
    let modifiedAt: String
    let modelId: String
}

// This protocol must conform with the data structure to save a game
public protocol LMGameModelType: Codable {
    var type: LMGameType { get }
    var metadata: LMMetaData { get set }
}

public struct LMGameModel: LMGameModelType {
    public var metadata: LMMetaData
    public let type: LMGameType
    public let id: String
    
    public init(id: String, type: LMGameType, modelId: String = LMConstants.metadataVersion) {
        self.id = id
        self.type = type
        self.metadata = LMMetaData(createdAt: Date().description,
                                   modifiedAt: Date().description,
                                   modelId: modelId)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(LMGameType.self, forKey: .type)
        self.id = try container.decode(String.self, forKey: .id)
        self.metadata = try container.decode(LMMetaData.self, forKey: .metadata)
    }
    
    public func getDozens() -> [[String]] {
        switch type {
        case .extraDozen(let extraDozen):
            return [extraDozen.dozens]
        case .normal(let normal):
            return [normal.dozens]
        case .extraValue(let extraValue):
            return [extraValue.dozens]
        case .multipleGame(let multipleGame):
            return multipleGame.dozens
        }
    }
    
    public func getExtraDozens() -> [String]? {
        switch type {
        case .extraDozen(let game):
            return game.extraDozen
        case .normal, .extraValue, .multipleGame:
            return nil
        }
    }
    
    public func getExtraValue() -> String? {
        switch type {
        case .extraValue(let game):
            return game.extraValue
        case .normal, .extraDozen, .multipleGame:
            return nil
        }
    }
}
