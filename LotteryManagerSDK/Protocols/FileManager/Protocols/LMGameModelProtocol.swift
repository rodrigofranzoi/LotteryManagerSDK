//
//  FileManagerLotteryProtocol.swift
//  MegaSena
//
//  Created by Rodrigo Scroferneker on 15/01/2023.
//  Copyright © 2023 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

public protocol GameFormModelType {
    var dozens: [String]? { get }
    var extraDozens: [String]? { get }
    var extraInput: String? { get }
    var teimosinha: Int? { get }
    var number: Int? { get }
    var isRecurrent: Bool? { get }
}

public protocol LMGameModelProtocol: LMRulesProtocol {
    func isValid(form: GameFormModelType) -> Bool
    func createGameModelType(form: GameFormModelType) -> LMGameModel
}

extension LMGameModelProtocol {
    public func isValid(form: GameFormModelType) -> Bool {
        switch self.gameRules {
        case .DozenContest(let rules):
            guard let dozens = form.dozens else { return false }
            if rules.minDozens > dozens.count { return false }
            if rules.maxDozens < dozens.count { return false }
        default: break
        }
        
        switch self.extraGameRules {
        case .DozenContest(let rules):
            guard let dozens = form.extraDozens else { return false }
            if rules.minDozens > dozens.count { return false }
            if rules.maxDozens < dozens.count { return false }
        case .SingleTicketContest:
            guard let _ = form.extraInput else { return false }
        default: break
        }
        
        guard let recurrent = form.isRecurrent,
              let segmented = form.teimosinha,
              let _ = form.number else { return false}
        
        if !recurrent && !self.teimosinha.contains(where: { $0 == segmented }) {
            return false
        }
        
        return true
    }
}
