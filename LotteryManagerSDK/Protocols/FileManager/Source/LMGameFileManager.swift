//
//  GameFileManager.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 15/11/2022.
//  Copyright © 2022 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol LMGameFileManagerType {
    var apiProtocol: LMSourceAPIType { get }
    var fileProvider: LMFileProvider { get }
    var idProvider: LMKeyGeneratorProtocol { get }
    
    func addGame(gameNumber: String, game: LMGameModel)
    func removeGame(gameNumber: String, game: LMGameModel)
    func editGame(gameNumber: String, game: LMGameModel, newGameNumber: String, newGame: LMGameModel)
    func addRecurrent(game: LMGameModel)
    func removeRecurrent(game: LMGameModel)
    func editRecurrent(game: LMGameModel, newGame: LMGameModel)
    func uniqueGameModel() -> MutableProperty<LMUniqueGameDataModel>
    func recurrentGameModel() -> MutableProperty<LMRecurrentDataModel>
}

class LMGameFileManager: LMGameFileManagerType {
    
    internal let apiProtocol: LMSourceAPIType
    internal let idProvider: LMKeyGeneratorProtocol
    internal let fileProvider: LMFileProvider
    
    private var recurrentId: String { apiProtocol.name + "-recurrent-games.json" }
    private var normalId: String { apiProtocol.name + "-games.json" }
    
    private var uniqueGame: MutableProperty<LMUniqueGameDataModel>
    private var recurrentGame: MutableProperty<LMRecurrentDataModel>
    
    init(apiProtocol: LMSourceAPIType,
         fileProvider: LMFileProvider = LMCoreFileProvider(),
         idProvider: LMKeyGeneratorProtocol = LMKeyGenerator()) {
        self.idProvider = idProvider
        self.fileProvider = fileProvider
        self.apiProtocol = apiProtocol
        
        self.uniqueGame = .init(.init(id: idProvider.getRandom(),
                                           contests: []))
        
        self.recurrentGame = .init(.init(id: idProvider.getRandom(),
                                           games: []))
        
        self.getGames { [weak self] uniqueGame in
            self?.uniqueGame = .init(uniqueGame)
            self?.setUniqueGameModelObservable()
        }
        
        self.getRecurrent { [weak self] recurrentGame in
            self?.recurrentGame = .init(recurrentGame)
            self?.setRecurrentGameModelObservable()
        }
    }
    
    func uniqueGameModel() -> MutableProperty<LMUniqueGameDataModel> {
        uniqueGame
    }
    
    func recurrentGameModel() -> MutableProperty<LMRecurrentDataModel> {
        recurrentGame
    }
    
    func addGame(gameNumber: String, game: LMGameModel) {
        var newGameObj = self.uniqueGame.value
        if let index = newGameObj.contests.firstIndex(where: { $0.number == gameNumber }) {
            var gamesList = newGameObj.contests[index]
            gamesList.games.append(game)
            newGameObj.contests[index] = gamesList
            self.uniqueGame.swap(newGameObj)
        } else {
            let contest = LMContest(id: self.idProvider.getRandom(),
                                  number: gameNumber,
                                  games: [game])
            newGameObj.contests.append(contest)
            newGameObj.contests = newGameObj.contests.sorted(by: { $0.number.localizedStandardCompare($1.number) == .orderedDescending })
            self.uniqueGame.swap(newGameObj)
        }
    }
    
    func removeGame(gameNumber: String, game: LMGameModel) {
        var newGameObj =  self.uniqueGame.value
        if let indexContest = newGameObj.contests.firstIndex(where: { $0.number == gameNumber }) {
            if let indexGame = newGameObj.contests[indexContest].games.firstIndex(where: { $0.id == game.id }) {
                newGameObj.contests[indexContest].games.remove(at: indexGame)
                if newGameObj.contests[indexContest].games.count == 0 {
                    newGameObj.contests.remove(at: indexContest)
                }
                self.uniqueGame.swap(newGameObj)
            }
        }
    }
    
    func editGame(gameNumber: String, game: LMGameModel, newGameNumber: String, newGame: LMGameModel) {
        
        if gameNumber != newGameNumber {
            var newGameObj =  self.uniqueGame.value
            if let indexContest = newGameObj.contests.firstIndex(where: { $0.number == gameNumber }) {
                if let indexGame = newGameObj.contests[indexContest].games.firstIndex(where: { $0.id == game.id }) {
                    newGameObj.contests[indexContest].games.remove(at: indexGame)
                    if newGameObj.contests[indexContest].games.count == 0 {
                        newGameObj.contests.remove(at: indexContest)
                    }
                }
            }
            addGame(gameNumber: newGameNumber, game: game)
            return
        }
        
        var newGameObj =  self.uniqueGame.value
        if let indexContest = newGameObj.contests.firstIndex(where: { $0.number == gameNumber }) {
            if let indexGame = newGameObj.contests[indexContest].games.firstIndex(where: { $0.id == game.id }) {
                newGameObj.contests[indexContest].games[indexGame] = newGame
                self.uniqueGame.swap(newGameObj)
            }
        }
    }

    func addRecurrent(game: LMGameModel) {
        var newGameObj = self.recurrentGame.value
        newGameObj.games.append(game)
        self.recurrentGame.swap(newGameObj)
    }
    
    func removeRecurrent(game: LMGameModel) {
        var newGameObj = self.recurrentGame.value
        if let indexGame = newGameObj.games.firstIndex(where: { $0.id == game.id }) {
            newGameObj.games.remove(at: indexGame)
            self.recurrentGame.swap(newGameObj)
        }
    }
    
    func editRecurrent(game: LMGameModel, newGame: LMGameModel) {
        var newGameObj = self.recurrentGame.value
        if let indexGame = newGameObj.games.firstIndex(where: { $0.id == game.id }) {
            newGameObj.games[indexGame] = newGame
            self.recurrentGame.swap(newGameObj)
        }
    }
    
    // MARK: Just for init
    // MARK: This method should not be used, mark as private
    private func getRecurrent(completion: @escaping (LMRecurrentDataModel)->Void) {
        fileProvider.callForObject(url: recurrentId) { (status: LMFetchStatus<LMRecurrentDataModel>) in
            switch status {
            case .succeeded(let object):
                completion(object)
            default:
                completion(LMRecurrentDataModel(id: self.idProvider.getRandom(),
                                              games: []))
            }
        }
    }
    
    // MARK: Just for init
    // MARK: This method should not be used, mark as private
    private func getGames(completion: @escaping (LMUniqueGameDataModel)->Void) {
        fileProvider.callForObject(url: normalId) { (status: LMFetchStatus<LMUniqueGameDataModel>) in
            switch status {
            case .succeeded(let object):
                completion(object)
            default:
                completion(LMUniqueGameDataModel(id: self.idProvider.getRandom(),
                                         contests: []))
            }
        }
    }
    
    private func setUniqueGameModelObservable() {
        uniqueGame
            .producer
            .skip(first: 1)
            .on(value: { [weak self] value in
                guard let self = self else { return }
                self.saveGameData(gameData: value, fileName: self.normalId)
            })
            .start()
    }
    private func setRecurrentGameModelObservable() {
        recurrentGame
            .producer
            .skip(first: 1)
            .on(value: { [weak self] value in
                guard let self = self else { return }
                self.saveGameData(gameData: value, fileName: self.recurrentId)
            })
            .start()
    }
    
    private func saveGameData<T>(gameData: T, fileName: String, onSucess: (()->Void)? = nil, onFailure: (()->Void)? = nil) where T: Codable {
        self.fileProvider.saveObject(url: fileName,
                                object: gameData,
                                onSucess: onSucess,
                                onFailure: onFailure)

    }
}
