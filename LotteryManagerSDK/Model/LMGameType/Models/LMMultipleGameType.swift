//
//  LMMultipleGameType.swift
//  LotteryManagerSDK
//
//  Created by Rodrigo Scroferneker on 13/03/2023.
//

import Foundation

public protocol LMMultipleGameType: Codable {
    var id: String { get }
    var dozens: [[String]] { get }
}

public struct LMMultipleGame: LMMultipleGameType {
    public let id: String
    public let dozens: [[String]]
    
    public init(id: String, dozens: [[String]]) {
        self.id = id
        self.dozens = dozens
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.dozens = try container.decode([[String]].self, forKey: .dozens)
    }
}
