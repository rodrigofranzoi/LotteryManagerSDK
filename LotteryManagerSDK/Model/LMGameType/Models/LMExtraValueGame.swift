//
//  LMExtraGame.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public protocol LMExtraValueGameType: Codable {
    var id: String { get }
    var dozens: [String] { get }
    var extraValue: String { get }
}

public struct LMExtraValueGame: LMExtraValueGameType {
    public let id: String
    public let dozens: [String]
    public let extraValue: String
    
    public init(id: String, dozens: [String], extraValue: String) {
        self.id = id
        self.dozens = dozens
        self.extraValue = extraValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.dozens = try container.decode([String].self, forKey: .dozens)
        self.extraValue = try container.decode(String.self, forKey: .extraValue)
    }
}
