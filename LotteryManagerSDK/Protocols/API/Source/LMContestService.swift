////
////  ContestService.swift
////  MegaSena
////
////  Created by Rodrigo Scroferneker on 29/11/2022.
////  Copyright © 2022 Rodrigo Franzoi Scroferneker. All rights reserved.
////
//
//import Foundation
//
//let TOKEN = "dGRjDsGNO3Nd1r3"
//let URL = "https://apiloterias.com.br/app/resultado?"
//
//class Path {
//    static let concurso = "concurso"
//    static let loteria = "loteria"
//    static let numero = "numero"
//    static let token = "token"
//}
//
//class LMContestService: LMContestServiceProtocol {
//
//    var apiProvider: LMContestAPIProvider
//    var apiProtocol: LMSourceAPIType
//    var cacheManager: LMContestFileManagerProtocol?
//
//    init(apiProvider: LMContestAPIProvider = LMContestAPI(),
//         cacheManager: LMContestFileManagerProtocol? = nil,
//         apiProtocol: LMSourceAPIType) {
//        self.apiProvider = apiProvider
//        self.cacheManager = cacheManager
//        self.apiProtocol = apiProtocol
//    }
//    
//    func fetchLottery<T>(contestNumber: Int?, completion: @escaping (LMFetchStatus<T>) -> Void) where T: DecodableOutput & LMContestServiceType {
//        var urlComponents = URLComponents(string: apiProtocol.url)
//        urlComponents?.queryItems = [URLQueryItem(name: Path.token, value: TOKEN),
//                                     URLQueryItem(name: Path.loteria, value: apiProtocol.name)]
//        
//        if let numero = contestNumber?.description {
//            urlComponents?.queryItems?.append(URLQueryItem(name: Path.concurso, value: numero))
//        }
//        
//        guard let url = urlComponents?.url else { return }
//        apiProvider.callForObject(url: url) { (status: LMFetchStatus<T>) in
//            completion(status)
//        }
//    }
//    
//    func fetchBundle<T>(numbers: [Int], completion: @escaping ([LMFetchStatus<T>]) -> Void) where T: DecodableOutput & LMContestServiceType {
//        let group = DispatchGroup()
//        var games: [LMFetchStatus<T>] =  Array(repeating: .other(.api), count: numbers.count)
//        for (index, number) in numbers.enumerated() {
//            group.enter()
//            fetchLottery(contestNumber: number)  { (status: LMFetchStatus<T>) in
//                group.leave()
//                games[index] = status
//            }
//        }
//        group.notify(queue: DispatchQueue.main) {
//            completion(games)
//        }
//    }
//}
