import Foundation

public class LMCoreFileProvider: LMFileProvider {
    
    public init() { }
    
    private var urlBase: NSString {
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        let dir = dirs[0] as NSString
        return dir
    }
    
    public func callForObject<T>(url: String, completion: @escaping (LMFetchStatus<T>) -> Void) where T : Decodable {
        let decoder = JSONDecoder()
        let path = urlBase.appendingPathComponent(url)
        if let data = try? Data(contentsOf: Foundation.URL(fileURLWithPath: path)),
           let decodedData = try? decoder.decode(T.self, from: data) {
            completion(.succeeded(decodedData))
        } else {
            completion(.other(.undefined))
        }
    }
    
    public func callForList<T>(url: String, completion: @escaping (LMFetchStatus<[T]>) -> Void) where T : Decodable {
        let decoder = JSONDecoder()
        let path = urlBase.appendingPathComponent(url)
        if let data = try? Data(contentsOf: Foundation.URL(fileURLWithPath: path)),
           let decodedData = try? decoder.decode([T].self, from: data) {
            completion(.succeeded(decodedData))
        } else {
            completion(.other(.undefined))
        }
    }
    
    public func saveObject<T>(url: String, object: T, onSucess: (() -> Void)?, onFailure: (() -> Void)?) where T : Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let path = urlBase.appendingPathComponent(url)
        guard let encodedData = try? encoder.encode(object) else { return }
        do {
            try encodedData.write(to: Foundation.URL(fileURLWithPath: path))
            onSucess?()
        } catch {
            onFailure?()
        }
    }
    
    public func saveObjects<T>(url: String, objects: [T], onSucess: (() -> Void)?, onFailure: (() -> Void)?) where T : Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let path = urlBase.appendingPathComponent(url)
        guard let encodedData = try? encoder.encode(objects) else { return }
        do {
            try encodedData.write(to: Foundation.URL(fileURLWithPath: path))
            onSucess?()
        } catch {
            onFailure?()
        }
    }
}
