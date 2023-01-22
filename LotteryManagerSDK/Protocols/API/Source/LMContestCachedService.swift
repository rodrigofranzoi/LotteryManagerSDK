//
//  ContestCachedService.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 30/11/2022.
//  Copyright © 2022 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

class LMContestCachedService<T>: LMContestCachedServiceProtocol where T: DecodableOutput & LMContestServiceType {

    var mainSource: LMContestServiceProtocol
    var cache: LMContestFileManagerProtocol
    var lastGameDefaults: LMLastGameDefaultsProtocol
    
    init(mainSource: LMContestServiceProtocol,
         cache: LMContestFileManagerProtocol,
         lastGameDefaults: LMLastGameDefaultsProtocol) {
        self.mainSource = mainSource
        self.cache = cache
        self.lastGameDefaults = lastGameDefaults
    }

    func fetchLottery<T>(contestNumber: Int? = nil, completion: @escaping (LMFetchStatus<T>)->Void) where T: DecodableOutput & LMContestServiceType {
        cache.getContests { [weak self] (cachedContests: [T]) in
            if let contestNumber = contestNumber,
               let game = cachedContests.first(where: { $0.contestNumber == contestNumber}),
               game.isCompleted {
                completion(.succeeded(game))
                return
            }
            
            self?.mainSource.fetchLottery(contestNumber: contestNumber) { (status: LMFetchStatus<T>) in
                switch status {
                case .succeeded(let game):
                    self?.cache.addContest(contest: game)
                    completion(.succeeded(game))
                    if contestNumber == nil {
                        self?.lastGameDefaults.lastGameNumber = game.contestNumber
                    } else if let lastGameNumber = self?.lastGameDefaults.lastGameNumber,
                              lastGameNumber > game.contestNumber {
                        self?.lastGameDefaults.lastGameNumber = game.contestNumber
                    }
                    return
                default:
                    if let contestNumber = contestNumber,
                       let game = cachedContests.first(where: { $0.contestNumber == contestNumber}) {
                        completion(.succeeded(game))
                        return
                    } else {
                        self?.cache.getLastContest { (contest: T?) in
                            guard let contest = contest else {
                                completion(.other(.noFileFound))
                                return
                            }
                            completion(.succeeded(contest))
                        }
                    }
                }
            }
        }
    }
 
    func fetchBundle<T>(contests: [Int], completion: @escaping ([LMFetchStatus<T>]) -> Void) where T: DecodableOutput & LMContestServiceType{
        let group = DispatchGroup()
        var games: [LMFetchStatus<T>] =  Array(repeating: .other(.api), count: contests.count)
        for (index, number) in contests.enumerated() {
            group.enter()
            fetchLottery(contestNumber: number)  { (status: LMFetchStatus<T>) in
                group.leave()
                // Avoid return duplicates
                games[index] = status
            }
        }
        group.notify(queue: DispatchQueue.main) {
            completion(games)
        }
    }
}
