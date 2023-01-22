//
//  LMContestAPI.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

class LMContestAPI: LMContestAPIProvider {

    private let session = URLSession.shared
    
    func callForObject<T>(url: URL, completion: @escaping (LMFetchStatus<T>) -> Void) where T : Codable {
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.other(.api))
                return
            }
            do {
                let results = try  JSONDecoder().decode(T.self, from: data)
                completion(.succeeded(results))
            } catch {
                completion(.other(.decoding))
            }
        }
        task.resume()
    }
    
    func callForList<T>(url: URL, completion: @escaping (LMFetchStatus<[T]>) -> Void) where T : Codable {
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.other(.api))
                return
            }
            do {
                let results = try  JSONDecoder().decode([T].self, from: data)
                completion(.succeeded(results))
            } catch {
                completion(.other(.decoding))
            }
        }
        task.resume()
    }
}
