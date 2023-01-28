import Foundation

public protocol LMKeyGeneratorProtocol {
    func getRandom() -> String
}

public class LMKeyGenerator: LMKeyGeneratorProtocol {
    public func getRandom() -> String{
        return UUID().uuidString.lowercased()
    }
}
