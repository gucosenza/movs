
import Foundation

class GenreManager {
    
    static let shared = GenreManager()
    private let networkManager = NetworkManager()
    var dictionaryGenres = [Int: String]()
    var arrayGenres: [String] = []
    
    func getGenreApi() {
        
        networkManager.loadGenre(onComplete: { (dictionaryGenres) in
            self.dictionaryGenres = dictionaryGenres
        }) { (error) in
            switch error {
            case .invalidJson:
                print("JSON Inválido")
            case .url:
                print("erro url")
            case .taskError(let error):
                print(error)
            case .noResponse:
                print("erro sem Response")
            case .noData:
                print("erro sem dados")
            case .responseStatusCode(let code):
                print("erro status code \(code)")
            }
        }
    }
    
    
    func getGenres(ids: [Int]) -> String {
        var genresMovie = ""
        for id in ids {
            genresMovie = genresMovie + dictionaryGenres[id]! + ", "
        }
        return String(genresMovie.dropLast(2))
    }
    
    func getGenresFilter() {
        arrayGenres.removeAll()
        for (key, value) in dictionaryGenres {
            arrayGenres.append(value)
        }
    }
}
