//
//  LMLastGameDefaults.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 20/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public class LMLastGameDefaults: LMLastGameDefaultsProtocol {
    private static let lastGameNumberKey = "LMLastGameNumberKey-"
    public var apiProtocol: LMSourceAPIType
    
    public init(apiProtocol: LMSourceAPIType) {
        self.apiProtocol = apiProtocol
    }
    
    public var lastGameNumber: Int {
        get {
            UserDefaults.standard.integer(forKey: Self.lastGameNumberKey + apiProtocol.name)
        }
        set {
            DispatchQueue.main.async {
                UserDefaults.standard.setValue(newValue, forKey:  Self.lastGameNumberKey + self.apiProtocol.name)
                UserDefaults.standard.synchronize()
            }
        }
    }
}
