//
//  File.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

// Structure of a collection of games and its number
public struct LMContest: Codable {
    let id: String
    let number: String
    var games: [LMGameModel]
}
