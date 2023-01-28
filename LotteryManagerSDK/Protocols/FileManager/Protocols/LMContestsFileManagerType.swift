//
//  LMContestsFileManagerType.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public protocol LMContestsFileManagerType: LMContestFileManagerProtocol {
    var apiProtocol: LMSourceAPIType { get }
    var apiProvider: LMContestAPIProvider { get }
    var fileProvider: LMFileProvider { get }
}
