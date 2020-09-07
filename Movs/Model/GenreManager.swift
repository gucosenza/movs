
import Foundation

class GenreManager {
    
    static let shared = GenreManager()
//    private let networkManager = NetworkManager()
    var dictionaryGenres = [Int: String]()
    
//    var dictionaryGenres = [28:"Action", 12:"Adventure", 16:"Animation", 35:"Comedy", 80:"Crime", 99:"Documentary", 18:"Drama", 10751:"Family", 14:"Fantasy", 36:"History", 27:"Horror", 10402:"Music", 9648:"Mystery", 10749:"Romance", 878:"Science Fiction", 10770:"TV Movie", 53:"Thriller", 10752:"War", 37:"Western"]
    
    func getGenreApi() {
        
//        networkManager.loadGenre(onComplete: { (dictionaryGenres) in
//            self.dictionaryGenres = dictionaryGenres
//        }) { (error) in
//            switch error {
//            case .invalidJson:
//                print("JSON Inválido")
//            case .url:
//                print("erro url")
//            case .taskError(let error):
//                print(error)
//            case .noResponse:
//                print("erro sem Response")
//            case .noData:
//                print("erro sem dados")
//            case .responseStatusCode(let code):
//                print("erro status code \(code)")
//            }
//        }
    }
    
    
    func getGenres(ids: [Int]) -> String {
        var genresMovie = ""
        for id in ids {
            genresMovie = genresMovie + dictionaryGenres[id]! + ", "
        }
        return String(genresMovie.dropLast(2))
    }
}
