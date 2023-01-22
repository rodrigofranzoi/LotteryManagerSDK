//
//  ContestServiceType.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 16/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

protocol LMContestServiceProtocol {
    var apiProtocol: LMSourceAPIType { get }
    
    func fetchLottery<T>(contestNumber: Int?, completion: @escaping (LMFetchStatus<T>) -> Void) where T: DecodableOutput & LMContestServiceType
    func fetchBundle<T>(numbers: [Int], completion: @escaping ([LMFetchStatus<T>]) -> Void) where T: DecodableOutput & LMContestServiceType
}
