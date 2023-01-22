//
//  ContestsFileManagerType.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 16/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

protocol LMContestFileManagerProtocol { 
    func addContest<T>(contest: T) where T: LMPersistenceType
    func getLastContest<T>(completion: @escaping (T?) -> Void) where T: LMPersistenceType
    func saveContests<T>(contests: [T]) where T: LMPersistenceType
    func getContests<T>(completion: @escaping ([T]) -> Void) where T: LMPersistenceType
}
