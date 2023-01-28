//
//  LMRecurrentDataModel.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

// Structure of a collection of games that is played every game
public struct LMRecurrentDataModel: Codable {
    let id: String
    var games: [LMGameModel]
    
    public init(id: String, games: [LMGameModel]) {
        self.id = id
        self.games = games
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.games = try container.decode([LMGameModel].self, forKey: .games)
    }
}
