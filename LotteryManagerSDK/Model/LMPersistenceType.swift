//
//  LotteryPersistenceProtocol.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 16/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public protocol LMPersistenceType: Codable {
    var contestNumber: Int { get }
    var isCompleted: Bool { get }
}
