import Foundation

public protocol LMFileProvider {
    func callForObject<T: Codable>(url: String, completion: @escaping (LMFetchStatus<T>) -> Void)
    func callForList<T: Codable>(url: String, completion: @escaping (LMFetchStatus<[T]>) -> Void)
    func saveObject<T: Encodable>(url: String, object: T, onSucess: (()->Void)?, onFailure: (()->Void)?)
    func saveObjects<T: Encodable>(url: String, objects: [T], onSucess: (()->Void)?, onFailure: (()->Void)?)
}
