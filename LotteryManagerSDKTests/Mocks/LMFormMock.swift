//
//  LMFormMock.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 13/03/2023.
//


import Foundation
import LotteryManagerSDK

struct LMFormMock: LotteryManagerSDK.GameFormModelType, Codable {
    var dozens: [String]?
    var extraDozens: [String]?
    var multipleDozens: [[String]]?
    var extraInput: String?
    var teimosinha: Int?
    var number: Int?
    var isRecurrent: Bool?
}
