
import Foundation

struct Config {
    
    static var apiKey: String {
        guard let value:String = Bundle.main.infoDictionary?["apiKey"] as? String else {return "erro"}
        return value
    }
    
    static var basePath: String {
        guard let value:String = Bundle.main.infoDictionary?["basePath"] as? String else {return "erro"}
        return value
    }
    
    static var imagePath: String {
        guard let value:String = Bundle.main.infoDictionary?["imagePath"] as? String else {return "erro"}
        return value
    }
    
}
