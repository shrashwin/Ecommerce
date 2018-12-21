

import Foundation

class CodableExtension {
    
    static func getData<T>(from object: T) -> Data? where T : Codable {
        
        do {
            return try JSONEncoder().encode(object)
        }
        catch {
            
        }
        return nil
    }
}


