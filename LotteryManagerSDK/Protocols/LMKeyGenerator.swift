import Foundation

protocol LMKeyGeneratorProtocol {
    func getRandom() -> String
}

class LMKeyGenerator: LMKeyGeneratorProtocol {
    func getRandom() -> String{
        return UUID().uuidString.lowercased()
    }
}
