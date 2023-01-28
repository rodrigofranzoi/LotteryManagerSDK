//
//  LMUniqueGameDataModel.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

// Structure of a collection of games that is played only once according with its number
public struct LMUniqueGameDataModel: Codable {
    public let id: String
    public var contests: [LMContest]
    
    public init(id: String, contests: [LMContest]) {
        self.id = id
        self.contests = contests
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.contests = try container.decode([LMContest].self, forKey: .contests)
    }
}
