//
//  LMContestAPIProvider.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public protocol LMContestAPIProvider {
    func callForObject<T: LMDecodableOutput>(url: URL, completion: @escaping (LMFetchStatus<T>) -> Void)
    func callForList<T: LMDecodableOutput>(url: URL, completion: @escaping (LMFetchStatus<[T]>) -> Void)
}
