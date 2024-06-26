//
//  ContestCachedService.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 30/11/2022.
//  Copyright © 2022 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public class LMContestCachedService: LMContestCachedServiceProtocol {
    
    public var mainSource: LMContestServiceProtocol
    public var cache: LMContestFileManagerProtocol
    public var lastGameDefaults: LMLastGameDefaultsProtocol
    
    public init(mainSource: LMContestServiceProtocol,
                cache: LMContestFileManagerProtocol,
                lastGameDefaults: LMLastGameDefaultsProtocol) {
        self.mainSource = mainSource
        self.cache = cache
        self.lastGameDefaults = lastGameDefaults
    }
    
    public func fetchLottery<U>(contestNumber: Int? = nil, completion: @escaping (LMFetchStatus<U>) -> Void) where U: LMDecodableOutput & LMContestServiceType {
        cache.getContests { [weak self] (cachedContests: [U]) in
            if let contestNumber = contestNumber,
               let game = cachedContests.first(where: { $0.contestNumber == contestNumber }),
               game.isCompleted {
                completion(.succeeded(game))
                return
            }
            
            self?.mainSource.fetchLottery(contestNumber: contestNumber) { (status: LMFetchStatus<U>) in
                switch status {
                case .succeeded(let game):
                    self?.cache.addContest(contest: game)
                    completion(.succeeded(game))
                    if contestNumber == nil {
                        self?.lastGameDefaults.lastGameNumber = game.contestNumber
                    } else if let lastGameNumber = self?.lastGameDefaults.lastGameNumber,
                              lastGameNumber < game.contestNumber {
                        self?.lastGameDefaults.lastGameNumber = game.contestNumber
                    }
                    return
                default:
                    if let contestNumber = contestNumber {
                        if let game = cachedContests.first(where: { $0.contestNumber == contestNumber }) {
                            completion(.succeeded(game))
                            return
                        } else {
                            completion(.other(.noFileFound))
                            return
                        }
                    } else {
                        self?.cache.getLastContest { (contest: U?) in
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
    
    public func fetchBundle<U>(contests: [Int], completion: @escaping ([LMFetchStatus<U>]) -> Void) where U: LMDecodableOutput & LMContestServiceType {
        let group = DispatchGroup()
        var games: [LMFetchStatus<U>] = Array(repeating: .other(.api), count: contests.count)
        for (index, number) in contests.enumerated() {
            group.enter()
            fetchLottery(contestNumber: number) { (status: LMFetchStatus<U>) in
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
