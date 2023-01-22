//
//  APIProtocol.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 15/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public protocol LMSourceAPIType {
    var name: String { get }
    var url: String { get }
}
