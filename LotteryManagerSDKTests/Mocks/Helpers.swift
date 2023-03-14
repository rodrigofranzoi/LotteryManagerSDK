//
//  Helpers.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 13/03/2023.
//

import Foundation

func loadFile<T: Decodable>(named filePath: String) -> T{
    let jsonData = NSData(contentsOfFile: filePath)!
    return try! JSONDecoder().decode(T.self, from: Data(referencing: jsonData))
}
