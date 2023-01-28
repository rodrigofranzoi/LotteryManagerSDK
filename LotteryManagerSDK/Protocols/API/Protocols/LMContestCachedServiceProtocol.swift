//
//  ContestCachedServiceType.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 16/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public protocol LMContestCachedServiceProtocol {
    var mainSource: LMContestServiceProtocol { get }
    var cache: LMContestFileManagerProtocol { get }
    var lastGameDefaults: LMLastGameDefaultsProtocol { get }
    
    func fetchLottery<T>(contestNumber: Int?, completion: @escaping (LMFetchStatus<T>)->Void) where T: LMDecodableOutput & LMContestServiceType
    func fetchBundle<T>(contests: [Int], completion: @escaping ([LMFetchStatus<T>]) -> Void) where T: LMDecodableOutput & LMContestServiceType
}
