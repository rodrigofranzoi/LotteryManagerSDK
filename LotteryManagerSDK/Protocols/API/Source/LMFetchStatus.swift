//
//  LMFetchStatus.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public enum LMFetchStatus<T> {
    case succeeded(T)
//    case cached(T)
    case failed(Error)
    case other(LMOther)
    
    public var isSuccess: Bool {
        switch self {
        case .succeeded: return true
        default: return false
        }
    }
    
    public var isFailure: Bool {
        switch self {
        case .succeeded: return false
        default: return true
        }
    }
}

public enum LMOther {
    case api
    case decoding
    case sessionExpired
    case internetConnection
    case undefined
    case noFileFound
    case noPath
}
