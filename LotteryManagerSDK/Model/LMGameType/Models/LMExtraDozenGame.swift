//
//  LMExtraDozenGame.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public protocol LMExtraDozenType: Codable {
    var id: String { get }
    var dozens: [String] { get }
    var extraDozen: [String] { get }
}

public struct LMExtraDozenGame: LMExtraDozenType {
    public let id: String
    public let dozens: [String]
    public let extraDozen: [String]
    
    public init(id: String, dozens: [String], extraDozen: [String]) {
        self.id = id
        self.dozens = dozens
        self.extraDozen = extraDozen
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.dozens = try container.decode([String].self, forKey: .dozens)
        self.extraDozen = try container.decode([String].self, forKey: .extraDozen)
    }
}
