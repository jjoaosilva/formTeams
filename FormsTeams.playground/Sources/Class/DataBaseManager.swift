import Foundation

public class DataBaseManager {
    
    public init() { }

    public func readDataBase(name: String = "dataBase") -> Cycle? {
        if let json = readLocalFile(forName: name) {
            return parse(jsonData: json)
        }
        return nil
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            return nil
        }
        return nil
    }

    private func parse(jsonData: Data) -> Cycle? {
        do {
            let decodedData = try JSONDecoder().decode(Cycle.self,
                                                       from: jsonData)
            return decodedData
        } catch {
            return nil
        }
    }
}


