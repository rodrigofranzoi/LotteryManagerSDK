//
//  ContestsFileManager.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 29/11/2022.
//  Copyright © 2022 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public class LMContestsFileManager: LMContestFileManagerProtocol {

    public var apiProtocol: LMSourceAPIType
    public var fileProvider: LMFileProvider
    
    public init(
        apiProtocol: LMSourceAPIType,
        fileProvider: LMFileProvider = LMCoreFileProvider()) {
        self.fileProvider = fileProvider
        self.apiProtocol = apiProtocol
    }
    
    public func addContest<T>(contest: T) where T : LMPersistenceType {
        getContests { (contests: [T]) in
            var newContests = contests
            if let index = contests.firstIndex(where: { savedContest in savedContest.contestNumber == contest.contestNumber}) {
                if contests[index].isCompleted == true && contest.isCompleted == false {
                    newContests[index] = contest
                    self.saveContests(contests: newContests)
                }
            } else {
                newContests.append(contest)
                newContests = newContests.sorted { c1, c2 in c1.contestNumber > c2.contestNumber }
                self.saveContests(contests: newContests)
            }
        }
    }
    
    public func getLastContest<T>(completion: @escaping (T?) -> Void) where T: LMPersistenceType {
        getContests { (contests: [T]) in
            let contest = contests.max { $0.contestNumber < $1.contestNumber }
            completion(contest)
        }
    }
    
    public func saveContests<T>(contests: [T]) where T: LMPersistenceType {
        self.fileProvider.saveObjects(
            url: apiProtocol.name + "-cache.json",
            objects: contests,
            onSucess: nil,
            onFailure: nil)
    }
    
    public func getContests<T>(completion: @escaping ([T]) -> Void) where T: LMPersistenceType {
        fileProvider.callForList(url: apiProtocol.name + "-cache.json") { (status: LMFetchStatus<[T]>) in
            switch status {
            case .succeeded(let contests):
                completion(contests)
            default:
                completion([])
            }
        }
    }
}
